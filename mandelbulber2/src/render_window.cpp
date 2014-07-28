/*
 * render_window.cpp
 *
 *  Created on: Mar 20, 2014
 *      Author: krzysztof
 */


#include "render_window.hpp"
#include "interface.hpp"
#include "fractal_list.hpp"
#include "system.hpp"
#include "settings.hpp"
#include "error_message.hpp"

#include <QtGui>
#include <QtUiTools/QtUiTools>
#include <QDial>
#include <QFileDialog>
#include <QColorDialog>
#include <QMessageBox>
#include "my_ui_loader.h"

#define _USE_MATH_DEFINES
#include <math.h>

RenderWindow::RenderWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::RenderWindow)
{
    ui->setupUi(this);
  	fractalWidgets = new QWidget*[4];
}

RenderWindow::~RenderWindow()
{
    delete ui;
    for(int i=0; i<4; i++)
    	delete fractalWidgets[i];
    delete[] fractalWidgets;
}


void RenderWindow::slotStartRender(void)
{
	mainInterface->StartRender();
}

void RenderWindow::slotStopRender(void)
{
	mainInterface->stopRequest = true;
}

void RenderWindow::load(void)
{
	printf("load\n");
}

void RenderWindow::slotDoubleSpinBoxChanged(double value)
{
	using namespace std;
	QString spinBoxName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(spinBoxName, &parameterName, &type);
	QString sliderName = QString("slider_") + parameterName;

	QSlider *slider = this->sender()->parent()->findChild<QSlider*>(sliderName);
	if (slider)
	{
		slider->setValue(value * 100.0);
	}
	else
	{
		qWarning() << "slotDoubleSpinBoxChanged() error: slider " << sliderName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotLogLineEditChanged(const QString &text)
{
	using namespace std;
	QString lineEditName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(lineEditName, &parameterName, &type);
	QString sliderName = QString("logslider_") + parameterName;

	QSlider *slider = this->sender()->parent()->findChild<QSlider*>(sliderName);
	if (slider)
	{
		double value = text.toDouble();
		if(value > 0.0)
		{
			int sliderPosition = log10(text.toDouble()) * 100.0;
			slider->setValue(sliderPosition);
		}
		else
		{
			qWarning() << "slotLogLineEditChanged() error: value from " << lineEditName << " is not greater zero" << endl;
		}
	}
	else
	{
		qWarning() << "slotLogLineEditChanged() error: slider " << sliderName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotIntSpinBoxChanged(int value)
{
	using namespace std;
	QString spinBoxName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(spinBoxName, &parameterName, &type);
	QString sliderName = QString("sliderInt_") + parameterName;

	QSlider *slider = this->sender()->parent()->findChild<QSlider*>(sliderName);
	if (slider)
	{
		slider->setValue(value);
	}
	else
	{
		qWarning() << "slotIntSpinBoxChanged() error: slider " << sliderName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotSpinBox3Changed(double value)
{
	using namespace std;
	QString spinBoxName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(spinBoxName, &parameterName, &type);
	QString sliderName = QString("slider3_") + parameterName;

	QSlider *slider = this->sender()->parent()->findChild<QSlider*>(sliderName);
	if (slider)
	{
		slider->setValue(value * 100.0);
	}
	else
	{
		qWarning() << "slotSpinBox3Changed() error: slider " << sliderName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotSpinBoxD3Changed(double value)
{
	using namespace std;
	QString spinBoxName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(spinBoxName, &parameterName, &type);
	QString dialName = QString("dial3_") + parameterName;

	QDial *dial = this->sender()->parent()->findChild<QDial*>(dialName);
	if (dial)
	{
		dial->setValue(value * 100.0);
	}
	else
	{
		qWarning() << "slotSpinBox3Changed() error: slider " << dialName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotSliderMoved(int value)
{
	using namespace std;
	QString sliderName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(sliderName, &parameterName, &type);
	QString spinBoxName = QString("spinbox_") + parameterName;

	QDoubleSpinBox *spinBox = this->sender()->parent()->findChild<QDoubleSpinBox*>(spinBoxName);
	if(spinBox)
	{
		spinBox->setValue(value/100.0);
	}
	else
	{
		qWarning() << "slotSliderMoved() error: spinbox " << spinBoxName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotLogSliderMoved(int value)
{
	using namespace std;
	QString sliderName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(sliderName, &parameterName, &type);
	QString lineEditName = QString("logedit_") + parameterName;

	QLineEdit *lineEdit = this->sender()->parent()->findChild<QLineEdit*>(lineEditName);
	if(lineEdit)
	{
		double dValue = pow(10.0, value/100.0);
		QString text = QString::number(dValue);
		lineEdit->setText(text);
	}
	else
	{
		qWarning() << "slotLogSliderMoved() error: lineEdit " << lineEditName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotIntSliderMoved(int value)
{
	using namespace std;
	QString sliderName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(sliderName, &parameterName, &type);
	QString spinboxName = QString("spinboxInt_") + parameterName;

	QSpinBox *spinbox = this->sender()->parent()->findChild<QSpinBox*>(spinboxName);
	if(spinbox)
	{
		spinbox->setValue(value);
	}
	else
	{
		qWarning() << "slotLogSliderMoved() error: lineEdit " << spinboxName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotSlider3Moved(int value)
{
	using namespace std;
	QString sliderName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(sliderName, &parameterName, &type);
	QString spinBoxName = QString("spinbox3_") + parameterName;

	QDoubleSpinBox *spinBox = this->sender()->parent()->findChild<QDoubleSpinBox*>(spinBoxName);
	if(spinBox)
	{
		spinBox->setValue(value/100.0);
	}
	else
	{
		qWarning() << "slotSlider3Moved() error: spinbox " << spinBoxName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotDial3Moved(int value)
{
	using namespace std;
	QString sliderName = this->sender()->objectName();
	QString type, parameterName;
	mainInterface->GetNameAndType(sliderName, &parameterName, &type);
	QString spinBoxName = QString("spinboxd3_") + parameterName;

	QDoubleSpinBox *spinBox = this->sender()->parent()->findChild<QDoubleSpinBox*>(spinBoxName);
	if(spinBox)
	{
		spinBox->setValue(value/100.0);
	}
	else
	{
		qWarning() << "slotDial3Moved() error: spinbox " << spinBoxName << " doesn't exists" << endl;
	}
}

void RenderWindow::slotPresedOnColorButton(void)
{
	QPushButton *pushButton = qobject_cast<QPushButton*>(this->sender());
	QString pushButtonName = pushButton->objectName();
	QColorDialog colorDialog(mainInterface->mainWindow);
	QColor color;
	color.setRed(pushButton->property("selectedColor_r").toInt() / 256);
	color.setGreen(pushButton->property("selectedColor_g").toInt() / 256);
	color.setBlue(pushButton->property("selectedColor_b").toInt() / 256);
	colorDialog.setCurrentColor(color);
	colorDialog.exec();
	color = colorDialog.currentColor();
	MakeIconForButton(color, pushButton);
	pushButton->setProperty("selectedColor_r", color.red() * 256);
	pushButton->setProperty("selectedColor_g", color.green() * 256);
	pushButton->setProperty("selectedColor_b", color.blue() * 256);
}

void RenderWindow::slotMenuSaveDocksPositions()
{
	settings.setValue("mainWindowGeometry", saveGeometry());
	settings.setValue("mainWindowState", saveState());
	qDebug() << "settings saved";
}

void RenderWindow::slotChangedFractalCombo(int index)
{
	QString comboName = this->sender()->objectName();
	int fractalNumber = comboName.right(1).toInt() - 1;

	if(fractalList[index].internalID > 0)
	{
		QString formulaName = fractalList[index].internalNane;
		QString uiFilename = systemData.sharedDir + "qt" + QDir::separator() + "fractal_" + formulaName + ".ui";

		if(fractalWidgets[fractalNumber]) delete fractalWidgets[fractalNumber];
		fractalWidgets[fractalNumber] = NULL;

		MyUiLoader loader;
		QFile uiFile(uiFilename);

		if(uiFile.exists())
		{
			uiFile.open(QFile::ReadOnly);
			fractalWidgets[fractalNumber] = loader.load(&uiFile);
			QVBoxLayout *layout = ui->dockWidget_fractal->findChild<QVBoxLayout*>("verticalLayout_fractal_" + QString::number(fractalNumber + 1));
			layout->addWidget(fractalWidgets[fractalNumber]);
			uiFile.close();
			fractalWidgets[fractalNumber]->show();
			mainInterface->ConnectSignalsForSlidersInWindow(fractalWidgets[fractalNumber]);
			mainInterface->SynchronizeInterfaceWindow(fractalWidgets[fractalNumber], &gParFractal[fractalNumber], cInterface::write);

			if(fractalList[index].internalID == fractal::kaleidoscopicIFS)
			{
				QWidget *pushButton_preset_dodecahedron = fractalWidgets[fractalNumber]->findChild<QWidget*>("pushButton_preset_dodecahedron");
				QApplication::connect(pushButton_preset_dodecahedron, SIGNAL(clicked()), this, SLOT(slotIFSDefaultsDodecahedron()));
				QWidget *pushButton_preset_icosahedron = fractalWidgets[fractalNumber]->findChild<QWidget*>("pushButton_preset_icosahedron");
				QApplication::connect(pushButton_preset_icosahedron, SIGNAL(clicked()), this, SLOT(slotIFSDefaultsIcosahedron()));
				QWidget *pushButton_preset_octahedron = fractalWidgets[fractalNumber]->findChild<QWidget*>("pushButton_preset_octahedron");
				QApplication::connect(pushButton_preset_octahedron, SIGNAL(clicked()), this, SLOT(slotIFSDefaultsOctahedron()));
				QWidget *pushButton_preset_menger_sponge = fractalWidgets[fractalNumber]->findChild<QWidget*>("pushButton_preset_menger_sponge");
				QApplication::connect(pushButton_preset_menger_sponge, SIGNAL(clicked()), this, SLOT(slotIFSDefaultsMengerSponge()));
				QWidget *pushButton_preset_reset = fractalWidgets[fractalNumber]->findChild<QWidget*>("pushButton_preset_reset");
				QApplication::connect(pushButton_preset_reset, SIGNAL(clicked()), this, SLOT(slotIFSDefaultsReset()));
			}
		}
		else
		{
			cErrorMessage::showMessage(QString("Can't open file ") + uiFilename + QString("\nFractal ui file can't be loaded"), cErrorMessage::errorMessage, mainInterface->mainWindow);
		}
	}
	else
	{
		if(fractalWidgets[fractalNumber]) delete fractalWidgets[fractalNumber];
		fractalWidgets[fractalNumber] = NULL;
	}

}

void RenderWindow::slotImageScrolledAreaResized(int width, int height)
{
	if (mainInterface->mainImage)
	{
		int selectedScale = ui->comboBox_image_preview_scale->currentIndex();

		if (selectedScale == 0)
		{
			double scale = mainInterface->CalcMainImageScale(0.0, width, height, mainInterface->mainImage);
			mainInterface->mainImage->CreatePreview(scale, width, height, mainInterface->renderedImage);
			mainInterface->mainImage->UpdatePreview();
			mainInterface->renderedImage->setMinimumSize(mainInterface->mainImage->GetPreviewWidth(), mainInterface->mainImage->GetPreviewHeight());
		}
	}
}

void RenderWindow::slotChangedImageScale(int index)
{
	if (mainInterface->mainImage)
	{
		double scale = mainInterface->ImageScaleComboSelection2Double(index);
		int areaWidth = ui->scrollAreaForImage->VisibleAreaWidth();
		int areaHeight = ui->scrollAreaForImage->VisibleAreaHeight();
		scale = mainInterface->CalcMainImageScale(scale, areaWidth, areaHeight, mainInterface->mainImage);

		mainInterface->mainImage->CreatePreview(scale, areaWidth, areaHeight, mainInterface->renderedImage);
		mainInterface->mainImage->UpdatePreview();
		mainInterface->renderedImage->setMinimumSize(mainInterface->mainImage->GetPreviewWidth(), mainInterface->mainImage->GetPreviewHeight());
	}
}

void RenderWindow::slotCameraMove()
{
	QString buttonName = this->sender()->objectName();
	mainInterface->MoveCamera(buttonName);
}

void RenderWindow::slotCameraRotation()
{
	QString buttonName = this->sender()->objectName();
	mainInterface->RotateCamera(buttonName);
}

void RenderWindow::slotCameraOrTargetEdited()
{
	mainInterface->CameraOrTargetEdited();
}

void RenderWindow::slotRotationEdited()
{
	mainInterface->RotationEdited();
}

void RenderWindow::slotCameraDistanceEdited()
{
	mainInterface->CameraDistanceEdited();
}

void RenderWindow::slotCameraDistanceSlider(int value)
{
	(void)value;
	mainInterface->CameraDistanceEdited();
}

void RenderWindow::slotCheckBoxHybridFractalChanged(int state)
{
	ui->label_formula_iterations_1->setEnabled(state);
	ui->spinboxInt_formula_iterations_1->setEnabled(state);
	ui->sliderInt_formula_iterations_1->setEnabled(state);
	ui->frame_iterations_formula_2->setEnabled(state);
	ui->frame_iterations_formula_3->setEnabled(state);
	ui->frame_iterations_formula_4->setEnabled(state);
	ui->scrollArea_fractal_2->setEnabled(state);
	ui->scrollArea_fractal_3->setEnabled(state);
	ui->scrollArea_fractal_4->setEnabled(state);
}

void RenderWindow::slotSaveSettings()
{
	cSettings parSettings(cSettings::formatCondensedText);
	mainInterface->SynchronizeInterface(gPar, gParFractal, cInterface::read);
	parSettings.CreateText(gPar, gParFractal);

	QFileDialog dialog(this);
	dialog.setFileMode(QFileDialog::AnyFile);
	dialog.setNameFilter(tr("Fractals (*.txt *.fract)"));
	dialog.setDirectory(systemData.dataDirectory + QDir::separator() + "settings" + QDir::separator());
	dialog.selectFile("settings.fract");
	dialog.setAcceptMode(QFileDialog::AcceptSave);
	QStringList filenames;
	if(dialog.exec())
	{
		filenames = dialog.selectedFiles();
		QString filename = filenames.first();
		parSettings.SaveToFile(filename);
	}
}

void RenderWindow::slotLoadSettings()
{
	cSettings parSettings(cSettings::formatFullText);

	QFileDialog dialog(this);
	dialog.setFileMode(QFileDialog::ExistingFile);
	dialog.setNameFilter(tr("Fractals (*.txt *.fract)"));
	dialog.setDirectory(systemData.dataDirectory + QDir::separator() + "settings" + QDir::separator());
	dialog.selectFile("settings.fract");
	dialog.setAcceptMode(QFileDialog::AcceptOpen);
	QStringList filenames;
	if(dialog.exec())
	{
		filenames = dialog.selectedFiles();
		QString filename = filenames.first();
		parSettings.LoadFromFile(filename);
		parSettings.Decode(gPar, gParFractal);
		mainInterface->SynchronizeInterface(gPar, gParFractal, cInterface::write);
	}
}

void RenderWindow::slotIFSDefaultsDodecahedron()
{
	int index = ui->tabWidget_fractals->currentIndex();
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::read);
	mainInterface->IFSDefaultsDodecahedron(&gParFractal[index]);
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::write);
}

void RenderWindow::slotIFSDefaultsIcosahedron()
{
	int index = ui->tabWidget_fractals->currentIndex();
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::read);
	mainInterface->IFSDefaultsIcosahedron(&gParFractal[index]);
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::write);
}

void RenderWindow::slotIFSDefaultsOctahedron()
{
	int index = ui->tabWidget_fractals->currentIndex();
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::read);
	mainInterface->IFSDefaultsOctahedron(&gParFractal[index]);
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::write);
}

void RenderWindow::slotIFSDefaultsMengerSponge()
{
	int index = ui->tabWidget_fractals->currentIndex();
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::read);
	mainInterface->IFSDefaultsMengerSponge(&gParFractal[index]);
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::write);
}

void RenderWindow::slotIFSDefaultsReset()
{
	int index = ui->tabWidget_fractals->currentIndex();
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::read);
	mainInterface->IFSDefaultsReset(&gParFractal[index]);
	mainInterface->SynchronizeInterfaceWindow(ui->tabWidget_fractals->currentWidget(), &gParFractal[index], cInterface::write);
}

void RenderWindow::slotAboutQt()
{
	QMessageBox::aboutQt(this);
}

void RenderWindow::slotAboutMandelbulber()
{
	QString text = "Mandelbulber\n";
	text += "version: " + QString(MANDELBULBER_VERSION_STRING) + ", build date: " + QString(__DATE__) + QString("\n");
	text += "\n";
	text += "Licence: GNU GPL version 3.0\n";
	text += "Copyright Ⓒ 2014 Krzysztof Marczak\n";
	text += "\n";
	text += "Thanks to many friends from www.fractalforums.com for help\n";
	text += "\n";
	text += "www.mandelbulber.com";

	QMessageBox::about(this, "About Mandelbulber", text);
}

//=================== rendered image widget ==================/

RenderedImage::RenderedImage(QWidget *parent)
    : QWidget(parent)
{ }

void RenderedImage::paintEvent(QPaintEvent *event)
{
  (void)event;
	mainInterface->mainImage->RedrawInWidget();
}


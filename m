Return-path: <richard.dorsch@gmail.com>
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	lee.jones@linaro.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	wim@iguana.be,
	jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH v3 3/6] Add Advantech iManager HWmon driver
Date: Sun, 10 Jan 2016 15:31:12 -0800
Message-Id: <1452468675-5827-4-git-send-email-richard.dorsch@gmail.com>
In-Reply-To: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 Documentation/hwmon/imanager       |   59 ++
 drivers/hwmon/Kconfig              |   12 +
 drivers/hwmon/Makefile             |    2 +
 drivers/hwmon/imanager-ec-hwmon.c  |  606 +++++++++++++++++++++
 drivers/hwmon/imanager-hwmon.c     | 1057 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/imanager/hwmon.h |  120 ++++
 6 files changed, 1856 insertions(+)
 create mode 100644 Documentation/hwmon/imanager
 create mode 100644 drivers/hwmon/imanager-ec-hwmon.c
 create mode 100644 drivers/hwmon/imanager-hwmon.c
 create mode 100644 include/linux/mfd/imanager/hwmon.h

diff --git a/Documentation/hwmon/imanager b/Documentation/hwmon/imanager
new file mode 100644
index 0000000..0705cf9
--- /dev/null
+++ b/Documentation/hwmon/imanager
@@ -0,0 +1,59 @@
+Kernel driver imanager_hwmon
+============================
+
+This platform driver provides support for iManager Hardware Monitoring
+and FAN control.
+
+This driver depends on imanager (mfd).
+
+Description
+-----------
+
+This driver provides support for the Advantech iManager Hardware Monitoring EC.
+
+The Advantech iManager supports up to 3 fan rotation speed sensors,
+3 temperature monitoring sources and up to 5 voltage sensors, VID, alarms and
+a automatic fan regulation strategy (as well as manual fan control mode).
+
+Temperatures are measured in degrees Celsius and measurement resolution is
+1 degC. An Alarm is triggered when the temperature gets higher than the high
+limit; it stays on until the temperature falls below the high limit.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. No fan
+speed divider support available.
+
+Voltage sensors (also known as IN sensors) report their values in millivolts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit.
+
+The driver supports automatic fan control mode known as Thermal Cruise.
+In this mode, the firmware attempts to keep the measured temperature in a
+predefined temperature range. If the temperature goes out of range, fan
+is driven slower/faster to reach the predefined range again.
+
+The mode works for fan1-fan3.
+
+sysfs attributes
+----------------
+
+pwm[1-3] - this file stores PWM duty cycle or DC value (fan speed) in range:
+	   0 (lowest speed) to 255 (full)
+
+pwm[1-3]_enable - this file controls mode of fan/temperature control:
+	* 0 Fan control disabled (fans set to maximum speed)
+	* 1 Manual mode, write to pwm[1-3] any value 0-255
+	* 2 "Fan Speed Cruise" mode
+
+pwm[1-3]_mode - controls if output is PWM or DC level
+        * 0 DC output
+        * 1 PWM output
+
+Speed Cruise mode (2)
+---------------------
+
+This mode tries to keep the fan speed constant within min/max speed.
+
+fan[1-3]_min - Minimum fan speed
+fan[1-3]_max - Maximum fan speed
+
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 80a73bf..776bb8a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -613,6 +613,18 @@ config SENSORS_CORETEMP
 	  sensor inside your CPU. Most of the family 6 CPUs
 	  are supported. Check Documentation/hwmon/coretemp for details.
 
+config SENSORS_IMANAGER
+	tristate "Advantech iManager Hardware Monitoring"
+	depends on MFD_IMANAGER
+	select HWMON_VID
+	help
+	  This enables support for Advantech iManager hardware monitoring
+	  of some Advantech SOM, MIO, AIMB, and PCM modules/boards.
+	  Requires mfd-core and imanager-core to function properly.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called imanager_hwmon.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 12a3239..53752bc 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -76,6 +76,8 @@ obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
 obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
 obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
+imanager_hwmon-objs		:= imanager-hwmon.o imanager-ec-hwmon.o
+obj-$(CONFIG_SENSORS_IMANAGER)	+= imanager_hwmon.o
 obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
diff --git a/drivers/hwmon/imanager-ec-hwmon.c b/drivers/hwmon/imanager-ec-hwmon.c
new file mode 100644
index 0000000..1920835
--- /dev/null
+++ b/drivers/hwmon/imanager-ec-hwmon.c
@@ -0,0 +1,606 @@
+/*
+ * Advantech iManager Hardware Monitoring core
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/bug.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/byteorder/generic.h>
+#include <linux/swab.h>
+#include <linux/mfd/imanager/ec.h>
+#include <linux/mfd/imanager/hwmon.h>
+
+#define HWM_STATUS_UNDEFINED_ITEM	2UL
+#define HWM_STATUS_UNDEFINED_DID	3UL
+#define HWM_STATUS_UNDEFINED_HWPIN	4UL
+
+/*
+ * FAN defs
+ */
+
+struct fan_dev_config {
+	u8	did,
+		hwpin,
+		tachoid,
+		status,
+		control,
+		temp_max,
+		temp_min,
+		temp_stop,
+		pwm_max,
+		pwm_min;
+	u16	rpm_max;
+	u16	rpm_min;
+	u8	debounce;	/* debounce time, not used */
+	u8	temp;		/* Current Thermal Zone Temperature */
+	u16	rpm_target;	/* RPM Target Speed, not used */
+};
+
+struct fan_status {
+	u32	sysctl	: 1,	/* System Control flag */
+		tacho	: 1,	/* FAN tacho source defined */
+		pulse	: 1,	/* FAN pulse type defined */
+		thermal	: 1,	/* Thermal zone init */
+		i2clink	: 1,	/* I2C protocol fail flag (thermal sensor) */
+		dnc	: 1,	/* don't care */
+		mode	: 2;	/* FAN Control mode */
+};
+
+struct fan_alert_limit {
+	u16	fan0_min,
+		fan0_max,
+		fan1_min,
+		fan1_max,
+		fan2_min,
+		fan2_max;
+};
+
+struct fan_alert_flag {
+	u32	fan0_min_alarm	: 1,
+		fan0_max_alarm	: 1,
+		fan1_min_alarm	: 1,
+		fan1_max_alarm	: 1,
+		fan2_min_alarm	: 1,
+		fan2_max_alarm	: 1,
+		dnc		: 2; /* don't care */
+};
+
+/*----------------------------------------------------*
+ * FAN Control bit field                              *
+ * enable:   0:Disabled, 1:Enabled                    *
+ * type:     0:PWM,      1:RPM                        *
+ * pulse:    0:Undefined 1:2 Pulse   2:4 Pulse        *
+ * tacho:    1:CPU FAN,  2:SYS1 FAN, 3:SYS2 FAN       *
+ * mode:     0:Off,      1:Full,     2:Manual, 3:Auto *
+ *- 7  6 ---- 5  4 --- 3  2 ----- 1 -------- 0 -------*
+ *  MODE   | TACHO  |  PULSE  |  TYPE  |    ENABLE    *
+ *----------------------------------------------------*/
+struct fan_ctrl {
+	u32	enable	: 1,	/* SmartFAN control on/off */
+		type	: 1,	/* FAN control type [0, 1] PWM/RPM */
+		pulse	: 2,	/* FAN pulse [0..2] */
+		tacho	: 2,	/* FAN Tacho Input [1..3] */
+		mode	: 2;	/* off/full/manual/auto */
+};
+
+enum fan_dev_ctrl {
+	CTRL_STATE = 3,
+	OPMODE,
+	IDSENSOR,
+	ACTIVE,
+	CTRL_MODE,
+};
+
+enum fan_limit {
+	LIMIT_PWM,
+	LIMIT_RPM,
+	LIMIT_TEMP,
+};
+
+static const char * const fan_temp_label[] = {
+	"Temp CPU",
+	"Temp SYS1",
+	"Temp SYS2",
+	NULL,
+};
+
+static const struct imanager_hwmon_device *hwmon;
+
+static inline int hwm_get_adc_value(u8 did)
+{
+	return imanager_read_word(EC_CMD_HWP_RD, did);
+}
+
+static inline int hwm_get_rpm_value(u8 did)
+{
+	return imanager_read_word(EC_CMD_HWP_RD, did);
+}
+
+static inline int hwm_get_pwm_value(u8 did)
+{
+	return imanager_read_byte(EC_CMD_HWP_RD, did);
+}
+
+static inline int hwm_set_pwm_value(u8 did, u8 val)
+{
+	return imanager_write_byte(EC_CMD_HWP_WR, did, val);
+}
+
+static int hwm_read_fan_config(int num, struct fan_dev_config *cfg)
+{
+	int ret;
+	struct ec_message msg = {
+		.rlen = 0xff, /* use alternative message body */
+		.wlen = 0,
+	};
+	struct fan_dev_config *_cfg = (struct fan_dev_config *)&msg.u.data;
+
+	if (WARN_ON(!cfg))
+		return -EINVAL;
+
+	memset(cfg, 0, sizeof(struct fan_dev_config));
+
+	ret = imanager_msg_read(EC_CMD_FAN_CTL_RD, num, &msg);
+	if (ret)
+		return ret;
+
+	if (!_cfg->did) {
+		pr_err("Invalid FAN%d device ID - possible firmware bug\n",
+			num);
+		return -ENODEV;
+	}
+
+	memcpy(cfg, &msg.u.data, sizeof(struct fan_dev_config));
+
+	return 0;
+}
+
+static int hwm_write_fan_config(int fnum, struct fan_dev_config *cfg)
+{
+	int ret;
+	struct ec_message msg = {
+		.rlen = 0,
+		.wlen = sizeof(struct fan_dev_config),
+	};
+
+	if (!cfg->did)
+		return -ENODEV;
+
+	msg.data = (u8 *)cfg;
+
+	ret = imanager_msg_write(EC_CMD_FAN_CTL_WR, fnum, &msg);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case 0:
+		break;
+	case HWM_STATUS_UNDEFINED_ITEM:
+	case HWM_STATUS_UNDEFINED_DID:
+	case HWM_STATUS_UNDEFINED_HWPIN:
+		return -EFAULT;
+	default:
+		pr_err("Unknown error status of fan%d (%d)\n", fnum, ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static inline void hwm_set_temp_limit(struct fan_dev_config *cfg,
+				      const struct hwm_fan_temp_limit *temp)
+{
+	cfg->temp_stop = temp->stop;
+	cfg->temp_min  = temp->min;
+	cfg->temp_max  = temp->max;
+}
+
+static inline void hwm_set_pwm_limit(struct fan_dev_config *cfg,
+				     const struct hwm_fan_limit *pwm)
+{
+	cfg->pwm_min = pwm->min;
+	cfg->pwm_max = pwm->max;
+}
+
+static inline void hwm_set_rpm_limit(struct fan_dev_config *cfg,
+				     const struct hwm_fan_limit *rpm)
+{
+	cfg->rpm_min = swab16(rpm->min);
+	cfg->rpm_max = swab16(rpm->max);
+}
+
+static inline void hwm_set_limit(struct fan_dev_config *cfg,
+				 const struct hwm_sensors_limit *limit)
+{
+	hwm_set_temp_limit(cfg, &limit->temp);
+	hwm_set_pwm_limit(cfg, &limit->pwm);
+	hwm_set_rpm_limit(cfg, &limit->rpm);
+}
+
+static int hwm_core_get_fan_alert_flag(struct fan_alert_flag *flag)
+{
+	int ret;
+	u8 *value = (u8 *)flag;
+
+	ret = imanager_acpiram_read_byte(EC_ACPIRAM_FAN_ALERT);
+	if (ret < 0)
+		return ret;
+
+	*value = ret;
+
+	return 0;
+}
+
+static int hwm_core_get_fan_alert_limit(int fnum,
+					struct hwm_smartfan *fan)
+{
+	int ret;
+	struct fan_alert_limit limit;
+	struct fan_alert_flag flag;
+
+	ret = imanager_acpiram_read_block(EC_ACPIRAM_FAN_SPEED_LIMIT,
+					 (u8 *)&limit, sizeof(limit));
+	if (ret < 0)
+		return ret;
+
+	ret = hwm_core_get_fan_alert_flag(&flag);
+	if (ret < 0)
+		return ret;
+
+	switch (fnum) {
+	case FAN_CPU:
+		fan->alert.min = swab16(limit.fan0_min);
+		fan->alert.max = swab16(limit.fan0_max);
+		fan->alert.min_alarm = flag.fan0_min_alarm;
+		fan->alert.max_alarm = flag.fan0_max_alarm;
+		break;
+	case FAN_SYS1:
+		fan->alert.min = swab16(limit.fan1_min);
+		fan->alert.max = swab16(limit.fan1_max);
+		fan->alert.min_alarm = flag.fan1_min_alarm;
+		fan->alert.max_alarm = flag.fan1_max_alarm;
+		break;
+	case FAN_SYS2:
+		fan->alert.min = swab16(limit.fan2_min);
+		fan->alert.max = swab16(limit.fan2_max);
+		fan->alert.min_alarm = flag.fan2_min_alarm;
+		fan->alert.max_alarm = flag.fan2_max_alarm;
+		break;
+	default:
+		pr_err("Unknown FAN ID %d\n", fnum);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hwm_core_fan_set_alert_limit(int fnum,
+					struct hwm_fan_alert *alert)
+{
+	int ret;
+	struct fan_alert_limit limit;
+
+	ret = imanager_acpiram_read_block(EC_ACPIRAM_FAN_SPEED_LIMIT,
+					 (u8 *)&limit, sizeof(limit));
+	if (ret < 0)
+		return ret;
+
+	switch (fnum) {
+	case FAN_CPU:
+		limit.fan0_min = swab16(alert->min);
+		limit.fan0_max = swab16(alert->max);
+		break;
+	case FAN_SYS1:
+		limit.fan1_min = swab16(alert->min);
+		limit.fan1_max = swab16(alert->max);
+		break;
+	case FAN_SYS2:
+		limit.fan2_min = swab16(alert->min);
+		limit.fan2_max = swab16(alert->max);
+		break;
+	default:
+		pr_err("Unknown FAN ID %d\n", fnum);
+		return -EINVAL;
+	}
+
+	return imanager_acpiram_write_block(EC_ACPIRAM_FAN_SPEED_LIMIT,
+					   (u8 *)&limit, sizeof(limit));
+}
+
+/* HWM CORE API */
+
+const char *hwm_core_adc_get_label(int num)
+{
+	if (WARN_ON(num >= hwmon->adc.num))
+		return NULL;
+
+	return hwmon->adc.attr[num].label;
+}
+
+const char *hwm_core_fan_get_label(int num)
+{
+	if (WARN_ON(num >= hwmon->fan.num))
+		return NULL;
+
+	return hwmon->fan.attr[num].label;
+}
+
+const char *hwm_core_fan_get_temp_label(int num)
+{
+	if (WARN_ON(num >= hwmon->fan.num))
+		return NULL;
+
+	return fan_temp_label[num];
+}
+
+int hwm_core_adc_is_available(int num)
+{
+	if (num >= EC_HWM_MAX_ADC)
+		return -EINVAL;
+
+	return hwmon->adc.attr[num].did ? 0 : -ENODEV;
+}
+
+int hwm_core_adc_get_value(int num, struct hwm_voltage *volt)
+{
+	int ret;
+
+	volt->valid = false;
+
+	ret = hwm_core_adc_is_available(num);
+	if (ret < 0)
+		return ret;
+
+	ret = hwm_get_adc_value(hwmon->adc.attr[num].did);
+	if (ret < 0)
+		return ret;
+
+	volt->value = ret * hwmon->adc.attr[num].scale;
+	volt->valid = true;
+
+	return 0;
+}
+
+int hwm_core_fan_get_ctrl(int num, struct hwm_smartfan *fan)
+{
+	int ret;
+	struct fan_dev_config cfg;
+	struct fan_ctrl *ctrl = (struct fan_ctrl *)&cfg.control;
+
+	if (WARN_ON((num >= HWM_MAX_FAN) || !fan))
+		return -EINVAL;
+
+	memset(fan, 0, sizeof(struct hwm_smartfan));
+
+	ret = hwm_read_fan_config(num, &cfg);
+	if (ret < 0)
+		return ret;
+
+	fan->pulse = ctrl->pulse;
+	fan->type = ctrl->type;
+
+	/*
+	 * It seems that fan->mode does not always report the correct
+	 * FAN mode so the only way of reporting the current FAN mode
+	 * is to read back ctrl->mode.
+	 */
+	fan->mode = ctrl->mode;
+
+	ret = hwm_get_rpm_value(cfg.tachoid);
+	if (ret < 0) {
+		pr_err("Failed to read FAN speed\n");
+		return ret;
+	}
+
+	fan->speed = ret;
+
+	ret = hwm_get_pwm_value(hwmon->fan.attr[num].did);
+	if (ret < 0) {
+		pr_err("Failed to read FAN%d PWM\n", num);
+		return ret;
+	}
+
+	fan->pwm = ret;
+
+	fan->alarm = (fan->pwm && !fan->speed) ? 1 : 0;
+
+	fan->limit.temp.min	= cfg.temp_min;
+	fan->limit.temp.max	= cfg.temp_max;
+	fan->limit.temp.stop	= cfg.temp_stop;
+	fan->limit.pwm.min	= cfg.pwm_min;
+	fan->limit.pwm.max	= cfg.pwm_max;
+	fan->limit.rpm.min	= swab16(cfg.rpm_min);
+	fan->limit.rpm.max	= swab16(cfg.rpm_max);
+
+	ret = hwm_core_get_fan_alert_limit(num, fan);
+	if (ret)
+		return ret;
+
+	fan->valid = true;
+
+	return 0;
+}
+
+int hwm_core_fan_set_ctrl(int num, int fmode, int ftype, int pwm, int pulse,
+			  struct hwm_sensors_limit *limit,
+			  struct hwm_fan_alert *alert)
+{
+	int ret;
+	struct fan_dev_config cfg;
+	struct fan_ctrl *ctrl = (struct fan_ctrl *)&cfg.control;
+	struct hwm_sensors_limit _limit = { {0, 0, 0}, {0, 0}, {0, 0} };
+
+	if (WARN_ON(num >= HWM_MAX_FAN))
+		return -EINVAL;
+
+	ret = hwm_read_fan_config(num, &cfg);
+	if (ret < 0) {
+		pr_err("Failed while reading FAN %s config\n",
+			hwmon->fan.attr[num].label);
+		return ret;
+	}
+
+	if (!limit)
+		limit = &_limit;
+
+	switch (fmode) {
+	case MODE_OFF:
+		ctrl->type = CTRL_PWM;
+		ctrl->mode = MODE_OFF;
+		break;
+	case MODE_FULL:
+		ctrl->type = CTRL_PWM;
+		ctrl->mode = MODE_FULL;
+		break;
+	case MODE_MANUAL:
+		ctrl->type = CTRL_PWM;
+		ctrl->mode = MODE_MANUAL;
+		ret = hwm_set_pwm_value(hwmon->fan.attr[num].did, pwm);
+		if (ret < 0)
+			return ret;
+		break;
+	case MODE_AUTO:
+		switch (ftype) {
+		case CTRL_PWM:
+			limit->rpm.min = 0;
+			limit->rpm.max = 0;
+			ctrl->type = CTRL_PWM;
+			break;
+		case CTRL_RPM:
+			limit->pwm.min = 0;
+			limit->pwm.max = 0;
+			ctrl->type = CTRL_RPM;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ctrl->mode = MODE_AUTO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hwm_set_limit(&cfg, limit);
+
+	ctrl->pulse = (pulse && (pulse < 3)) ? pulse : 0;
+	ctrl->enable = 1;
+
+	ret = hwm_write_fan_config(num, &cfg);
+	if (ret < 0)
+		return ret;
+
+	if (alert)
+		return hwm_core_fan_set_alert_limit(num, alert);
+
+	return 0;
+}
+
+int hwm_core_fan_is_available(int num)
+{
+	if (WARN_ON(num >= HWM_MAX_FAN))
+		return -EINVAL;
+
+	return hwmon->fan.active & (1 << num) &&
+		hwmon->fan.attr[num].did ? 0 : -ENODEV;
+}
+
+static int hwm_core_fan_set_limit(int num, int fan_limit,
+				  struct hwm_sensors_limit *limit)
+{
+	struct fan_dev_config cfg;
+	int ret;
+
+	if (WARN_ON(num >= HWM_MAX_FAN))
+		return -EINVAL;
+
+	ret = hwm_read_fan_config(num, &cfg);
+	if (ret < 0) {
+		pr_err("Failed while reading FAN %s config\n",
+			hwmon->fan.attr[num].label);
+		return ret;
+	}
+
+	switch (fan_limit) {
+	case LIMIT_PWM:
+		hwm_set_pwm_limit(&cfg, &limit->pwm);
+		break;
+	case LIMIT_RPM:
+		hwm_set_rpm_limit(&cfg, &limit->rpm);
+		break;
+	case LIMIT_TEMP:
+		hwm_set_temp_limit(&cfg, &limit->temp);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return hwm_write_fan_config(num, &cfg);
+}
+
+int hwm_core_fan_set_rpm_limit(int num, int min, int max)
+{
+	struct hwm_sensors_limit limit = {
+		.rpm = {
+			.min = min,
+			.max = max,
+		},
+	};
+
+	return hwm_core_fan_set_limit(num, LIMIT_RPM, &limit);
+}
+
+int hwm_core_fan_set_pwm_limit(int num, int min, int max)
+{
+	struct hwm_sensors_limit limit = {
+		.pwm = {
+			.min = min,
+			.max = max,
+		},
+	};
+
+	return hwm_core_fan_set_limit(num, LIMIT_PWM, &limit);
+}
+
+int hwm_core_fan_set_temp_limit(int num, int stop, int min, int max)
+{
+	struct hwm_sensors_limit limit = {
+		.temp = {
+			.stop = stop,
+			.min = min,
+			.max = max,
+		},
+	};
+
+	return hwm_core_fan_set_limit(num, LIMIT_TEMP, &limit);
+}
+
+int hwm_core_adc_get_max_count(void)
+{
+	return hwmon->adc.num;
+}
+
+int hwm_core_fan_get_max_count(void)
+{
+	return hwmon->fan.num;
+}
+
+int hwm_core_init(void)
+{
+	hwmon = imanager_get_hwmon_device();
+	if (!hwmon)
+		return -ENODEV;
+
+	return 0;
+}
+
diff --git a/drivers/hwmon/imanager-hwmon.c b/drivers/hwmon/imanager-hwmon.c
new file mode 100644
index 0000000..f836c7e
--- /dev/null
+++ b/drivers/hwmon/imanager-hwmon.c
@@ -0,0 +1,1057 @@
+/*
+ * Advantech iManager Hardware Monitoring driver
+ * Derived from nct6775 driver
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/mfd/imanager/core.h>
+#include <linux/mfd/imanager/hwmon.h>
+
+struct imanager_hwmon_data {
+	struct imanager_device_data *idev;
+	bool valid;	/* if set, below values are valid */
+	struct hwm_data hwm;
+	int adc_num;
+	int fan_num;
+	unsigned long samples;
+	unsigned long last_updated;
+	const struct attribute_group *groups[3];
+};
+
+static inline u32 in_from_reg(u16 val)
+{
+	return clamp_val(DIV_ROUND_CLOSEST(val * SCALE_IN, 1000), 0, 65535);
+}
+
+static inline u16 in_to_reg(u32 val)
+{
+	return clamp_val(DIV_ROUND_CLOSEST(val * 1000, SCALE_IN), 0, 65535);
+}
+
+static struct imanager_hwmon_data *
+imanager_hwmon_update_device(struct device *dev)
+{
+	struct imanager_hwmon_data *data = dev_get_drvdata(dev);
+	int i;
+
+	mutex_lock(&data->idev->lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		/* Measured voltages */
+		for (i = 0; i < data->adc_num; i++)
+			hwm_core_adc_get_value(i, &data->hwm.volt[i]);
+
+		/* Measured fan speeds */
+		for (i = 0; i < data->fan_num; i++)
+			hwm_core_fan_get_ctrl(i, &data->hwm.fan[i]);
+
+		data->last_updated = jiffies;
+		data->valid = true;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return data;
+}
+
+static ssize_t
+show_in(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+
+	return sprintf(buf, "%u\n", in_from_reg(adc->value));
+}
+
+static ssize_t
+show_in_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+
+	return sprintf(buf, "%u\n", in_from_reg(adc->min));
+}
+
+static ssize_t
+show_in_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+
+	return sprintf(buf, "%u\n", in_from_reg(adc->max));
+}
+
+static ssize_t
+store_in_min(struct device *dev, struct device_attribute *attr,
+	     const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&data->idev->lock);
+
+	adc->min = in_to_reg(val);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+store_in_max(struct device *dev, struct device_attribute *attr,
+	     const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&data->idev->lock);
+
+	adc->max = in_to_reg(val);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_in_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+	int val = 0;
+
+	if (adc->valid)
+		val = (adc->value < adc->min) || (adc->value > adc->max);
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t
+show_in_average(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+
+	if (adc->average)
+		adc->average =
+			DIV_ROUND_CLOSEST(adc->average * data->samples +
+					  adc->value, ++data->samples);
+	else {
+		adc->average = adc->value;
+		data->samples = 1;
+	}
+
+	return sprintf(buf, "%u\n", in_from_reg(adc->average));
+}
+
+static ssize_t
+show_in_lowest(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+
+	if (!adc->lowest)
+		adc->lowest = adc->highest = adc->value;
+	else if (adc->value < adc->lowest)
+		adc->lowest = adc->value;
+
+	return sprintf(buf, "%u\n", in_from_reg(adc->lowest));
+}
+
+static ssize_t
+show_in_highest(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+
+	if (!adc->highest)
+		adc->highest = adc->value;
+	else if (adc->value > adc->highest)
+		adc->highest = adc->value;
+
+	return sprintf(buf, "%u\n", in_from_reg(adc->highest));
+}
+
+static ssize_t
+store_in_reset_history(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_voltage *adc = &data->hwm.volt[index];
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&data->idev->lock);
+
+	if (val == 1) {
+		adc->lowest = 0;
+		adc->highest = 0;
+	} else {
+		count = -EINVAL;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+
+	return sprintf(buf, "%u\n", fan->temp * 1000);
+}
+
+static ssize_t
+show_fan_in(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+
+	return sprintf(buf, "%u\n", fan->valid ? fan->speed : 0);
+}
+
+static inline int is_alarm(const struct hwm_smartfan *fan)
+{
+	/*
+	 * Do not set ALARM flag if FAN is in speed cruise mode (3)
+	 * as this mode automatically turns on the FAN
+	 * Set ALARM flag when pwm is set but speed is 0 as this
+	 * could be a defective FAN or no FAN is present
+	 */
+	return (!fan->valid ||
+		((fan->mode == MODE_AUTO) && fan->alarm) ||
+		(fan->speed > fan->limit.rpm.max));
+}
+
+static ssize_t
+show_fan_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+
+	return sprintf(buf, "%u\n", fan->valid ? is_alarm(fan) : 0);
+}
+
+static ssize_t
+show_fan_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_fan_limit *rpm = &data->hwm.fan[index - 1].limit.rpm;
+
+	return sprintf(buf, "%u\n", rpm->min);
+}
+
+static ssize_t
+show_fan_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_fan_limit *rpm = &data->hwm.fan[index - 1].limit.rpm;
+
+	return sprintf(buf, "%u\n", rpm->max);
+}
+
+static ssize_t
+store_fan_min(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+	struct hwm_fan_limit *rpm = &fan->limit.rpm;
+	unsigned long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	/* do not apply value if not in 'fan cruise mode' */
+	if (fan->mode != MODE_AUTO)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_rpm_limit(index - 1, val, rpm->max);
+	hwm_core_fan_get_ctrl(index - 1, fan); /* update */
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+store_fan_max(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+	struct hwm_fan_limit *rpm = &fan->limit.rpm;
+	unsigned long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	/* do not apply value if not in 'fan cruise mode' */
+	if (fan->mode != MODE_AUTO)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_rpm_limit(index - 1, rpm->min, val);
+	hwm_core_fan_get_ctrl(index - 1, fan);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	u32 val = DIV_ROUND_CLOSEST(data->hwm.fan[index - 1].pwm * 255, 100);
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t
+store_pwm(struct device *dev, struct device_attribute *attr,
+	  const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+	unsigned long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val = DIV_ROUND_CLOSEST(val * 100, 255);
+
+	mutex_lock(&data->idev->lock);
+
+	switch (fan->mode) {
+	case MODE_MANUAL:
+		hwm_core_fan_set_ctrl(index - 1, MODE_MANUAL, CTRL_PWM,
+				      val, 0, NULL, NULL);
+		break;
+	case MODE_AUTO:
+		if (fan->type == CTRL_RPM)
+			break;
+		hwm_core_fan_set_ctrl(index - 1, MODE_AUTO, CTRL_PWM,
+				      val, 0, &fan->limit, &fan->alert);
+		break;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_pwm_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%u\n", data->hwm.fan[index - 1].limit.pwm.min);
+}
+
+static ssize_t
+show_pwm_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%u\n", data->hwm.fan[index - 1].limit.pwm.max);
+}
+
+static ssize_t
+show_pwm_enable(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	struct hwm_smartfan *fan = &data->hwm.fan[nr];
+
+	if (fan->mode == MODE_OFF)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", fan->mode - 1);
+}
+
+static ssize_t
+store_pwm_enable(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	struct hwm_smartfan *fan = &data->hwm.fan[nr];
+	unsigned long mode = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &mode);
+	if (err < 0)
+		return err;
+
+	if (mode > MODE_AUTO)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	switch (mode) {
+	case 0:
+		if (mode != 0)
+			hwm_core_fan_set_ctrl(nr, MODE_FULL, CTRL_PWM, 100,
+					      fan->pulse, NULL, NULL);
+		break;
+	case 1:
+		if (mode != 1)
+			hwm_core_fan_set_ctrl(nr, MODE_MANUAL, CTRL_PWM, 0,
+					      fan->pulse, NULL, NULL);
+		break;
+	case 2:
+		if (mode != 2)
+			hwm_core_fan_set_ctrl(nr, MODE_AUTO, fan->type, 0,
+					      fan->pulse, &fan->limit, NULL);
+		break;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_pwm_mode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_smartfan *fan = &data->hwm.fan[index - 1];
+
+	if (fan->mode == MODE_OFF)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", fan->type == CTRL_PWM ? 1 : 0);
+}
+
+static ssize_t
+store_pwm_mode(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	struct hwm_smartfan *fan = &data->hwm.fan[nr];
+	unsigned long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	if (fan->mode != MODE_AUTO)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_ctrl(nr, fan->mode, val ? CTRL_RPM : CTRL_PWM,
+			      fan->pwm, fan->pulse, &fan->limit, &fan->alert);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_temp_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	int val = data->hwm.fan[nr].limit.temp.min;
+
+	return sprintf(buf, "%d\n", val * 1000);
+}
+
+static ssize_t
+show_temp_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	int val = data->hwm.fan[nr].limit.temp.max;
+
+	return sprintf(buf, "%u\n", val * 1000);
+}
+
+static ssize_t
+show_temp_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	struct hwm_smartfan *fan = &data->hwm.fan[nr];
+	struct hwm_fan_temp_limit *temp = &fan->limit.temp;
+
+	return sprintf(buf, "%u\n", (fan->temp && (fan->temp >= temp->max)));
+}
+
+static ssize_t
+store_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	struct hwm_smartfan *fan = &data->hwm.fan[nr];
+	struct hwm_fan_temp_limit *temp = &fan->limit.temp;
+	long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val = DIV_ROUND_CLOSEST(val, 1000);
+
+	if (val > 100)
+		return -EINVAL;
+
+	/* do not apply value if not in 'fan cruise mode' */
+	if (fan->mode != MODE_AUTO)
+		return -EINVAL;
+
+	/* The EC imanager provides three different temperature limit values
+	 * (stop, min, and max) where stop indicates a minimum temp value
+	 * (threshold) from which the FAN will turn off.  We are setting
+	 * temp_stop to the same value as temp_min.
+	 */
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_temp_limit(nr, val, val, temp->max);
+	hwm_core_fan_get_ctrl(nr, fan);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+store_temp_max(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index - 1;
+	struct hwm_smartfan *fan = &data->hwm.fan[nr];
+	struct hwm_fan_temp_limit *temp = &fan->limit.temp;
+	long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val = DIV_ROUND_CLOSEST(val, 1000);
+
+	if (val > 100)
+		return -EINVAL;
+
+	/* do not apply value if not in 'fan cruise mode' */
+	if (fan->mode != MODE_AUTO)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_temp_limit(nr, temp->stop, temp->min, val);
+	hwm_core_fan_get_ctrl(nr, fan);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+store_pwm_min(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_fan_limit *pwm = &data->hwm.fan[index - 1].limit.pwm;
+	long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val = DIV_ROUND_CLOSEST(val * 100, 255);
+
+	if (val > 100)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_pwm_limit(index - 1, val, pwm->max);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+store_pwm_max(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct imanager_hwmon_data *data = imanager_hwmon_update_device(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct hwm_fan_limit *pwm = &data->hwm.fan[index - 1].limit.pwm;
+	long val = 0;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val = DIV_ROUND_CLOSEST(val * 100, 255);
+
+	if (val > 100)
+		return -EINVAL;
+
+	mutex_lock(&data->idev->lock);
+
+	hwm_core_fan_set_pwm_limit(index - 1, pwm->min, val);
+
+	mutex_unlock(&data->idev->lock);
+
+	return count;
+}
+
+static ssize_t
+show_in_label(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%s\n", hwm_core_adc_get_label(index));
+}
+
+static ssize_t
+show_temp_label(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%s\n", hwm_core_fan_get_temp_label(index - 1));
+}
+
+static ssize_t
+show_fan_label(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%s\n", hwm_core_fan_get_label(index - 1));
+}
+
+/*
+ * Sysfs callback functions
+ */
+
+static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_in_label, NULL, 0);
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
+static SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min,
+			  store_in_min, 0);
+static SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max,
+			  store_in_max, 0);
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_in_alarm, NULL, 0);
+
+static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_in_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
+static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min,
+			  store_in_min, 1);
+static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max,
+			  store_in_max, 1);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_in_alarm, NULL, 1);
+
+static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_in_label, NULL, 2);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
+static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min,
+			  store_in_min, 2);
+static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max,
+			  store_in_max, 2);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_in_alarm, NULL, 2);
+
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp_min,
+			  store_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp_max,
+			  store_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 1);
+
+static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_temp_label, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, show_temp_min,
+			  store_temp_min, 2);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max,
+			  store_temp_max, 2);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 2);
+
+static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_temp_label, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR, show_temp_min,
+			  store_temp_min, 3);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max,
+			  store_temp_max, 3);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, show_fan_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_in, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
+			  store_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan1_max, S_IWUSR | S_IRUGO, show_fan_max,
+			  store_fan_max, 1);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 1);
+
+static SENSOR_DEVICE_ATTR(fan2_label, S_IRUGO, show_fan_label, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_in, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
+			  store_fan_min, 2);
+static SENSOR_DEVICE_ATTR(fan2_max, S_IWUSR | S_IRUGO, show_fan_max,
+			  store_fan_max, 2);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 2);
+
+static SENSOR_DEVICE_ATTR(fan3_label, S_IRUGO, show_fan_label, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_in, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
+			  store_fan_min, 3);
+static SENSOR_DEVICE_ATTR(fan3_max, S_IWUSR | S_IRUGO, show_fan_max,
+			  store_fan_max, 3);
+static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm1_min, S_IWUSR | S_IRUGO, show_pwm_min,
+			  store_pwm_min, 1);
+static SENSOR_DEVICE_ATTR(pwm1_max, S_IWUSR | S_IRUGO, show_pwm_max,
+			  store_pwm_max, 1);
+static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 1);
+static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 1);
+
+static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm2_min, S_IWUSR | S_IRUGO, show_pwm_min,
+			  store_pwm_min, 2);
+static SENSOR_DEVICE_ATTR(pwm2_max, S_IWUSR | S_IRUGO, show_pwm_max,
+			  store_pwm_max, 2);
+static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 2);
+static SENSOR_DEVICE_ATTR(pwm2_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 2);
+
+static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3);
+static SENSOR_DEVICE_ATTR(pwm3_min, S_IWUSR | S_IRUGO, show_pwm_min,
+			  store_pwm_min, 3);
+static SENSOR_DEVICE_ATTR(pwm3_max, S_IWUSR | S_IRUGO, show_pwm_max,
+			  store_pwm_max, 3);
+static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
+			  store_pwm_enable, 3);
+static SENSOR_DEVICE_ATTR(pwm3_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
+			  store_pwm_mode, 3);
+
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, show_in, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr1_min, S_IWUSR | S_IRUGO, show_in_min,
+			  store_in_min, 4);
+static SENSOR_DEVICE_ATTR(curr1_max, S_IWUSR | S_IRUGO, show_in_max,
+			  store_in_max, 4);
+static SENSOR_DEVICE_ATTR(curr1_alarm, S_IRUGO, show_in_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr1_average, S_IRUGO, show_in_average, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr1_lowest, S_IRUGO, show_in_lowest, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr1_highest, S_IRUGO, show_in_highest, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr1_reset_history, S_IWUSR, NULL,
+			  store_in_reset_history, 4);
+
+static SENSOR_DEVICE_ATTR(cpu0_vid, S_IRUGO, show_in, NULL, 3);
+
+static struct attribute *imanager_in_attributes[] = {
+	&sensor_dev_attr_in0_label.dev_attr.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+
+	NULL
+};
+
+static umode_t
+imanager_in_is_visible(struct kobject *kobj, struct attribute *attr, int index)
+{
+	int max_count = hwm_core_adc_get_max_count();
+
+	if (max_count >= 3)
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group imanager_group_in = {
+	.attrs = imanager_in_attributes,
+	.is_visible = imanager_in_is_visible,
+};
+
+static struct attribute *imanager_other_attributes[] = {
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_min.dev_attr.attr,
+	&sensor_dev_attr_curr1_max.dev_attr.attr,
+	&sensor_dev_attr_curr1_alarm.dev_attr.attr,
+	&sensor_dev_attr_curr1_average.dev_attr.attr,
+	&sensor_dev_attr_curr1_lowest.dev_attr.attr,
+	&sensor_dev_attr_curr1_highest.dev_attr.attr,
+	&sensor_dev_attr_curr1_reset_history.dev_attr.attr,
+
+	&sensor_dev_attr_cpu0_vid.dev_attr.attr,
+
+	NULL
+};
+
+static umode_t
+imanager_other_is_visible(struct kobject *kobj,
+			  struct attribute *attr, int index)
+{
+	int max_count = hwm_core_adc_get_max_count();
+
+	/*
+	 * There are either 3 or 5 VINs
+	 * vin3 is current monitoring
+	 * vin4 is CPU VID
+	 */
+	if (max_count > 3)
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group imanager_group_other = {
+	.attrs = imanager_other_attributes,
+	.is_visible = imanager_other_is_visible,
+};
+
+static struct attribute *imanager_fan_attributes[] = {
+	&sensor_dev_attr_fan1_label.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_max.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_fan2_label.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_max.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_fan3_label.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_max.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_min.dev_attr.attr,
+	&sensor_dev_attr_pwm1_max.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
+
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm2_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2_max.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_mode.dev_attr.attr,
+
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm3_min.dev_attr.attr,
+	&sensor_dev_attr_pwm3_max.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_mode.dev_attr.attr,
+
+	NULL
+};
+
+static umode_t
+imanager_fan_is_visible(struct kobject *kobj, struct attribute *attr, int index)
+{
+	int err;
+
+	if ((index >= 0) && (index <= 14)) { /* fan */
+		err = hwm_core_fan_is_available(index / 5);
+		if (err < 0)
+			return 0;
+	} else if ((index >= 15) && (index <= 29)) { /* temp */
+		err = hwm_core_fan_is_available((index - 15) / 5);
+		if (err < 0)
+			return 0;
+	} else if ((index >= 30) && (index <= 34)) { /* pwm */
+		err = hwm_core_fan_is_available((index - 30) / 5);
+		if (err < 0)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group imanager_group_fan = {
+	.attrs = imanager_fan_attributes,
+	.is_visible = imanager_fan_is_visible,
+};
+
+/*
+ * Module stuff
+ */
+static int imanager_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *idev = dev_get_drvdata(dev->parent);
+	struct imanager_hwmon_data *data;
+	struct device *hwmon_dev;
+	int err, i, num_attr_groups = 0;
+
+	if (!idev) {
+		dev_err(dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
+	err = hwm_core_init();
+	if (err) {
+		dev_err(dev, "Hwmon core init failed\n");
+		return -EIO;
+	}
+
+	data = devm_kzalloc(dev, sizeof(struct imanager_hwmon_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->idev = idev;
+	platform_set_drvdata(pdev, data);
+
+	data->adc_num = hwm_core_adc_get_max_count();
+	data->fan_num = hwm_core_fan_get_max_count();
+
+	for (i = 0; i < data->fan_num; i++) {
+		/* set active fan to automatic speed control */
+		hwm_core_fan_set_ctrl(i, MODE_AUTO, CTRL_RPM, 0, 0,
+				      NULL, NULL);
+		hwm_core_fan_get_ctrl(i, &data->hwm.fan[i]);
+	}
+
+	data->groups[num_attr_groups++] = &imanager_group_in;
+
+	if (data->adc_num > 3)
+		data->groups[num_attr_groups++] = &imanager_group_other;
+
+	if (data->fan_num)
+		data->groups[num_attr_groups++] = &imanager_group_fan;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+				"imanager_hwmon", data, data->groups);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct platform_driver imanager_hwmon_driver = {
+	.driver = {
+		.name  = "imanager_hwmon",
+	},
+	.probe	= imanager_hwmon_probe,
+};
+
+module_platform_driver(imanager_hwmon_driver);
+
+MODULE_DESCRIPTION("Advantech iManager HWmon Driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager_hwmon");
diff --git a/include/linux/mfd/imanager/hwmon.h b/include/linux/mfd/imanager/hwmon.h
new file mode 100644
index 0000000..2a7e191
--- /dev/null
+++ b/include/linux/mfd/imanager/hwmon.h
@@ -0,0 +1,120 @@
+/*
+ * Advantech iManager Hardware Monitoring core
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __HWMON_H__
+#define __HWMON_H__
+
+#include <linux/types.h>
+
+#define HWM_MAX_ADC	5
+#define HWM_MAX_FAN	3
+
+/* Voltage computation (10-bit ADC, 0..3V input) */
+#define SCALE_IN	2933	/* (3000mV / (2^10 - 1)) * 1000 */
+
+/* Default Voltage Sensors */
+struct hwm_voltage {
+	bool valid;	/* if set, below values are valid */
+
+	int value;
+	int min;
+	int max;
+	int average;
+	int lowest;
+	int highest;
+
+};
+
+struct hwm_fan_temp_limit {
+	int stop;
+	int min;
+	int max;
+};
+
+struct hwm_fan_limit {
+	int min;
+	int max;
+};
+
+struct hwm_fan_alert {
+	int min;
+	int max;
+	int min_alarm;
+	int max_alarm;
+};
+
+struct hwm_sensors_limit {
+	struct hwm_fan_temp_limit temp;
+	struct hwm_fan_limit	  pwm;
+	struct hwm_fan_limit	  rpm;
+};
+
+struct hwm_smartfan {
+	bool valid;	/* if set, below values are valid */
+
+	int mode;
+	int type;
+	int pwm;
+	int speed;
+	int pulse;
+	int alarm;
+	int temp;
+
+	struct hwm_sensors_limit limit;
+	struct hwm_fan_alert	 alert;
+};
+
+struct hwm_data {
+	struct hwm_voltage	volt[HWM_MAX_ADC];
+	struct hwm_smartfan	fan[HWM_MAX_FAN];
+};
+
+enum fan_unit {
+	FAN_CPU,
+	FAN_SYS1,
+	FAN_SYS2,
+};
+
+enum fan_ctrl_type {
+	CTRL_PWM,
+	CTRL_RPM,
+};
+
+enum fan_mode {
+	MODE_OFF,
+	MODE_FULL,
+	MODE_MANUAL,
+	MODE_AUTO,
+};
+
+int hwm_core_init(void);
+
+int hwm_core_adc_is_available(int num);
+int hwm_core_adc_get_max_count(void);
+int hwm_core_adc_get_value(int num, struct hwm_voltage *volt);
+const char *hwm_core_adc_get_label(int num);
+
+int hwm_core_fan_is_available(int num);
+int hwm_core_fan_get_max_count(void);
+int hwm_core_fan_get_ctrl(int num, struct hwm_smartfan *fan);
+int hwm_core_fan_set_ctrl(int num, int fmode, int ftype, int pwm, int pulse,
+			  struct hwm_sensors_limit *limit,
+			  struct hwm_fan_alert *alert);
+
+int hwm_core_fan_set_rpm_limit(int num, int min, int max);
+int hwm_core_fan_set_pwm_limit(int num, int min, int max);
+int hwm_core_fan_set_temp_limit(int num, int stop, int min, int max);
+
+const char *hwm_core_fan_get_label(int num);
+const char *hwm_core_fan_get_temp_label(int num);
+
+#endif
-- 
2.7.0

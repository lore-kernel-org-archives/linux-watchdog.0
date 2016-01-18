Return-path: <lee.jones@linaro.org>
Date: Mon, 18 Jan 2016 07:40:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: richard.dorsch@gmail.com, linux-kernel@vger.kernel.org,
	lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	jdelvare@suse.com, wim@iguana.be, jo.sunga@advantech.com
Subject: Re: [PATCH v3 3/6] Add Advantech iManager HWmon driver
Message-ID: <20160118074038.GH28745@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-4-git-send-email-richard.dorsch@gmail.com>
 <569BE312.4010609@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <569BE312.4010609@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 17 Jan 2016, Guenter Roeck wrote:

> On 01/10/2016 03:31 PM, richard.dorsch@gmail.com wrote:
> >From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Tell us about the device.

> >Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> >---
> >  Documentation/hwmon/imanager       |   59 ++
> >  drivers/hwmon/Kconfig              |   12 +
> >  drivers/hwmon/Makefile             |    2 +
> >  drivers/hwmon/imanager-ec-hwmon.c  |  606 +++++++++++++++++++++
> >  drivers/hwmon/imanager-hwmon.c     | 1057 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/imanager/hwmon.h |  120 ++++

I'm not keen on stuffing header files in /include/linux/mfd/.  Please
re-locate them to somewhere specific to hwmon.


[...]

> >diff --git a/include/linux/mfd/imanager/hwmon.h b/include/linux/mfd/imanager/hwmon.h
> >new file mode 100644
> >index 0000000..2a7e191
> >--- /dev/null
> >+++ b/include/linux/mfd/imanager/hwmon.h
> >@@ -0,0 +1,120 @@
> >+/*
> >+ * Advantech iManager Hardware Monitoring core
> >+ *
> >+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
> >+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
> >+ *
> >+ * This program is free software; you can redistribute  it and/or modify it
> >+ * under  the terms of  the GNU General  Public License as published by the
> >+ * Free Software Foundation;  either version 2 of the  License, or (at your
> >+ * option) any later version.
> >+ */
> >+
> >+#ifndef __HWMON_H__
> >+#define __HWMON_H__

Less generic.

> >+#include <linux/types.h>
> >+
> >+#define HWM_MAX_ADC	5
> >+#define HWM_MAX_FAN	3
> >+
> >+/* Voltage computation (10-bit ADC, 0..3V input) */
> >+#define SCALE_IN	2933	/* (3000mV / (2^10 - 1)) * 1000 */
> >+
> >+/* Default Voltage Sensors */
> >+struct hwm_voltage {
> >+	bool valid;	/* if set, below values are valid */
> >+
> >+	int value;
> >+	int min;
> >+	int max;
> >+	int average;
> >+	int lowest;
> >+	int highest;
> >+
> >+};
> >+
> >+struct hwm_fan_temp_limit {
> >+	int stop;
> >+	int min;
> >+	int max;
> >+};
> >+
> >+struct hwm_fan_limit {
> >+	int min;
> >+	int max;
> >+};
> >+
> >+struct hwm_fan_alert {
> >+	int min;
> >+	int max;
> >+	int min_alarm;
> >+	int max_alarm;
> >+};
> >+
> >+struct hwm_sensors_limit {
> >+	struct hwm_fan_temp_limit temp;
> >+	struct hwm_fan_limit	  pwm;
> >+	struct hwm_fan_limit	  rpm;
> >+};
> >+
> >+struct hwm_smartfan {
> >+	bool valid;	/* if set, below values are valid */
> >+
> >+	int mode;
> >+	int type;
> >+	int pwm;
> >+	int speed;
> >+	int pulse;
> >+	int alarm;
> >+	int temp;
> >+
> >+	struct hwm_sensors_limit limit;
> >+	struct hwm_fan_alert	 alert;
> >+};
> >+
> >+struct hwm_data {
> >+	struct hwm_voltage	volt[HWM_MAX_ADC];
> >+	struct hwm_smartfan	fan[HWM_MAX_FAN];
> >+};
> >+
> >+enum fan_unit {
> >+	FAN_CPU,
> >+	FAN_SYS1,
> >+	FAN_SYS2,
> >+};
> >+
> >+enum fan_ctrl_type {
> >+	CTRL_PWM,
> >+	CTRL_RPM,
> >+};
> >+
> >+enum fan_mode {
> >+	MODE_OFF,
> >+	MODE_FULL,
> >+	MODE_MANUAL,
> >+	MODE_AUTO,
> >+};

Are these used outside of the driver?

If not, consider moving them into the *.c file.

> >+int hwm_core_init(void);
> >+
> >+int hwm_core_adc_is_available(int num);
> >+int hwm_core_adc_get_max_count(void);
> >+int hwm_core_adc_get_value(int num, struct hwm_voltage *volt);
> >+const char *hwm_core_adc_get_label(int num);
> >+
> >+int hwm_core_fan_is_available(int num);
> >+int hwm_core_fan_get_max_count(void);
> >+int hwm_core_fan_get_ctrl(int num, struct hwm_smartfan *fan);
> >+int hwm_core_fan_set_ctrl(int num, int fmode, int ftype, int pwm, int pulse,
> >+			  struct hwm_sensors_limit *limit,
> >+			  struct hwm_fan_alert *alert);
> >+
> >+int hwm_core_fan_set_rpm_limit(int num, int min, int max);
> >+int hwm_core_fan_set_pwm_limit(int num, int min, int max);
> >+int hwm_core_fan_set_temp_limit(int num, int stop, int min, int max);
> >+
> >+const char *hwm_core_fan_get_label(int num);
> >+const char *hwm_core_fan_get_temp_label(int num);

Are all of these exported somewhere?

> >+#endif
> >
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

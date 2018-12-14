Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbeLNMrF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Dec 2018 07:47:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so5573209wml.2
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Dec 2018 04:47:04 -0800 (PST)
Date: Fri, 14 Dec 2018 12:47:01 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Message-ID: <20181214124701.GZ4497@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543571742-17995-1-git-send-email-p.paillet@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:

> The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
> STMicroelectronics. 
> The STPMIC1 regulators supply power to an application processor as well as 
> to external system peripherals such as DDR, Flash memories and system
> devices. It also features onkey button input and an hardware watchdog.
> The STPMIC1 is controlled via I2C. 
> 
> Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> as parent.
> 
> STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> 
> Pascal Paillet (7):
> changes in v7:
> * rebase on regul/for-next
> 
>   dt-bindings: mfd: document stpmic1
>   mfd: stpmic1: add stpmic1 driver
>   dt-bindings: input: document stpmic1 pmic onkey
>   input: stpmic1: add stpmic1 onkey driver
>   dt-bindings: watchdog: document stpmic1 pmic watchdog
>   watchdog: stpmic1: add stpmic1 watchdog driver
>   regulator: stpmic1: fix regulator_lock usage

Could you please remove any patches which have been applied and
[RESEND]?

Also, is Dmitry planning on Acking:

  dt-bindings: input: document stpmic1 pmic onkey

... or is Rob's Ack enough?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

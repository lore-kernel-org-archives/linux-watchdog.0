Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38950 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeK1VQE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Nov 2018 16:16:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id n133so1954897wmd.4
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Nov 2018 02:14:55 -0800 (PST)
Date: Wed, 28 Nov 2018 10:14:52 +0000
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
Subject: Re: [PATCH v6 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20181128101452.GE4272@dell>
References: <1543337529-22301-1-git-send-email-p.paillet@st.com>
 <1543337529-22301-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543337529-22301-3-git-send-email-p.paillet@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 27 Nov 2018, Pascal PAILLET-LME wrote:

> STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v6:
> * replace i2c_device_id by of_device_id
> * fix commit message and Kconfig description
> 
>  drivers/mfd/Kconfig         |  16 ++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/stpmic1.c       | 213 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 442 insertions(+)
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 include/linux/mfd/stpmic1.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

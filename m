Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46186 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFDu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 10 Oct 2018 01:03:50 -0400
Date: Tue, 9 Oct 2018 14:44:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: kbuild-all@01.org,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v3 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
Message-ID: <20181009214450.GA13702@roeck-us.net>
References: <1539016176-4072-9-git-send-email-p.paillet@st.com>
 <201810090846.it9ed9td%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810090846.it9ed9td%fengguang.wu@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 09, 2018 at 08:47:26AM +0800, kbuild test robot wrote:
> Hi pascal,
> 
> Thank you for the patch! Perhaps something to improve:
> 

[ ... ]

>     42	
>     43	static int pmic_wdt_stop(struct watchdog_device *wdd)
>     44	{
>     45		struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
>     46	
>     47		return regmap_update_bits(wdt->pmic->regmap,
>   > 48					  WCHDG_CR, WDT_START_MASK, ~WDT_START);

Maybe use

#define WDT_STOP	0

instead, or just write 0. ~WDT_START may be convenient but not really correct.

Guenter

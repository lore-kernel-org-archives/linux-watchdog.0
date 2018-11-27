Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbeK0TzL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Nov 2018 14:55:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so17637009wmi.3
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Nov 2018 00:57:59 -0800 (PST)
Date: Tue, 27 Nov 2018 08:57:42 +0000
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
Subject: Re: [PATCH v5 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20181127085742.GG4272@dell>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-3-git-send-email-p.paillet@st.com>
 <20181113074037.GC29388@dell>
 <5BFC2B69.1050204@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BFC2B69.1050204@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 26 Nov 2018, Pascal PAILLET-LME wrote:
> Hi Lee,
> I have just one question regarding i2c_device_id.

Don't forget to trim your responses.

Lots of unrequired quotes here.

[...]

> >> +static const struct i2c_device_id stpmic1_id[] = {
> >> +	{ "stpmic1"},
> >> +	{}
> >> +};
> > I don't think this is required any more.
> should I replace with the following ?
> 
> static const struct of_device_id stpmic1_of_match[] = {
>      { .compatible = "st,stpmic1", },
>      {},
> };
> MODULE_DEVICE_TABLE(of, stpmic1_of_match);

I think it should have had that already.  So yes, please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

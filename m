Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36571 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdHNQ2C (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 12:28:02 -0400
Received: by mail-wr0-f173.google.com with SMTP id y41so11555778wrd.3
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Aug 2017 09:28:01 -0700 (PDT)
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
To: Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, rtc-linux@googlegroups.com,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
 <20170814084340.65morabelapfegph@ninjato> <20170814162219.GX8569@atomide.com>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <c5e65e34-f308-f601-ba0b-d96792591727@linaro.org>
Date: Mon, 14 Aug 2017 17:27:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170814162219.GX8569@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 14/08/17 17:22, Tony Lindgren wrote:
> * Wolfram Sang <wsa@the-dreams.de> [170814 01:43]:
>>
>>>> Given the triviality of the change for non-MFD subsystems, can we apply
>>>> this for 4.14?
>>>
>>> I can't apply anything without Acks for *all* of the subsystems above.
>>
>> Well, there are cases when you can. Those should be exceptions and well
>> justified, of course.
>>
>>> My suggestion would be to collect the Acks you've received up until
>>> this point and identify which SS's are still lacking in change log
>>> section of a RESEND.
>>
>> I agree, though, that I can try a second round to get the acks.
> 
> As long as it's been compile tested with omap2plus_defconfig:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Don't recall if I sent an ack before but I do remember the patch... so 
from a backlight PoV:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


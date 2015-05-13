Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35431 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbEMNrA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 May 2015 09:47:00 -0400
Message-ID: <555355C1.9090907@roeck-us.net>
Date: Wed, 13 May 2015 06:46:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
References: <cover.1429280614.git.stwiss.opensource@diasemi.com> <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com> <20150510095838.GF3338@piout.net> <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com> <20150513125858.GX3338@piout.net> <55534BEF.7020409@roeck-us.net> <20150513133741.GY3338@piout.net>
In-Reply-To: <20150513133741.GY3338@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/13/2015 06:37 AM, Alexandre Belloni wrote:
> On 13/05/2015 at 06:04:47 -0700, Guenter Roeck wrote :
>> Don't know how this is handled for rtc drivers, but in other subsystems
>> we just live with the original name. I don't see a need to rename a driver
>> just because it starts supporting more hardware, and xxx is weird anyway
>> since it suggests everything from 000 to 999, which is much worse than
>> just sticking with 9063.
>>
>
> Yes, in particular if at some point in time a new IP matching those xxx
> is completely different from the previous one. I'm not fond of renaming
> the driver either but if diasemi thinks that what they want, I'm open to
> let it happen. But clearly, I don't want to end up in a situation like
> the tlv320aic where you don't know which driver correspond to which
> chip:
>
> sound/soc/codecs/tlv320aic31xx.c
> sound/soc/codecs/tlv320aic31xx.h
> sound/soc/codecs/tlv320aic32x4.c
> sound/soc/codecs/tlv320aic32x4.h
> sound/soc/codecs/tlv320aic3x.c
> sound/soc/codecs/tlv320aic3x.h
> sound/soc/codecs/tlv320dac33.c
> sound/soc/codecs/tlv320dac33.h
>
> Go figure that the tlv320aic3104 can be supported by both tlv320aic3x.c
> and tlv320aic32x4.c but not tlv320aic31xx.c...
>

Unfortunately that is exactly what is going to happen.

Guenter


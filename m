Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33750 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbbDRP7O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Apr 2015 11:59:14 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YjV9F-002zic-Fu
	for linux-watchdog@vger.kernel.org; Sat, 18 Apr 2015 15:59:13 +0000
Message-ID: <55327E21.304@roeck-us.net>
Date: Sat, 18 Apr 2015 08:54:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: S Twiss <stwiss.opensource@diasemi.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V1 0/6]  COVER LETTER
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1429280614.git.stwiss.opensource@diasemi.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/17/2015 07:23 AM, S Twiss wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
>
> This patch set adds support for the Dialog DA9062 Power Management IC.
>
> In this patch set the following is provided:
>   - [PATCH V1 1/6]: MFD core support
>   - [PATCH V1 2/6]: BUCK and LDO regulator driver
>   - [PATCH V1 3/6]: RTC driver
>   - [PATCH V1 4/6]: OnKey driver
>   - [PATCH V1 5/6]: Watchdog driver
>   - [PATCH V1 6/6]: Add bindings for all DA9062 components
>
> This patch applies against linux-next and v4.0
>
> Thank you,
> Steve Twiss, Dialog Semiconductor Ltd.
>

Hi Steve,

It might make sense to use something better than "COVER LETTER" as subject line.

Thanks,
Guenter


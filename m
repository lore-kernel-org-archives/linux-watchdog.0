Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60632 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751484AbbK0Opu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Nov 2015 09:45:50 -0500
Date: Fri, 27 Nov 2015 15:45:48 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Harald Geyer <harald@ccbib.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wolfram Sang <wsa@the-dreams.de>, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151127144548.GA22136@piout.net>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
 <20151127100254.GR19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151127100254.GR19888@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 27/11/2015 at 11:02:54 +0100, Uwe Kleine-König wrote :
> OK, I found a i.MX28 machine in our repository:
> 
> 	barebox# mw 0x80056080 0xbabecafe
> 	barebox# boot
> 	...
> 	linux# reboot
> 	barebox# md 0x80056080+4
> 	80056080: babecafe
> 
> After a power cycle the value disappears (I didn't check the details, if
> there is a battery it might be empty).
> 

Yeah, you'd have to ensure that the crystal power domain (VDDXTAL) stays powered.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45963 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab3KYNVB (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Nov 2013 08:21:01 -0500
Message-ID: <52934E7C.9040102@ti.com>
Date: Mon, 25 Nov 2013 15:19:56 +0200
From: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>
MIME-Version: 1.0
To: Sekhar Nori <nsekhar@ti.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Strashko Grygorii <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 0/6] Update Davinci watchdog driver
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com> <52934B6C.4060308@ti.com>
In-Reply-To: <52934B6C.4060308@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/25/2013 03:06 PM, Sekhar Nori wrote:
> On Monday 18 November 2013 10:48 PM, Ivan Khoronzhuk wrote:
>> These patches are intended to update Davinci watchdog to use WDT core
>> and reuse driver for keystone arch, because Keystone uses the similar
>> IP like Davinci.
>
> This series causes a regression on all DaVinci platforms because after
> the series is applied the watchdog device does not get registered at
> all. Since you changed the device name please include a patch to fix the
> platform references too.
>
> Thanks,
> Sekhar
>

Ok, I will replace

-- 
Regards,
Ivan Khoronzhuk

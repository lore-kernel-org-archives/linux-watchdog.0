Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59126 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbaLDO2i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Dec 2014 09:28:38 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XwXOX-002vB3-LM
	for linux-watchdog@vger.kernel.org; Thu, 04 Dec 2014 14:28:37 +0000
Message-ID: <54806F2A.7070107@roeck-us.net>
Date: Thu, 04 Dec 2014 06:26:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>	<1408495538-27480-9-git-send-email-linux@roeck-us.net> <CAMuHMdVqCa+m1oMkuRHcTZKw2CWNHJVotWBwfTnfBNT11UPEjw@mail.gmail.com>
In-Reply-To: <CAMuHMdVqCa+m1oMkuRHcTZKw2CWNHJVotWBwfTnfBNT11UPEjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/04/2014 05:36 AM, Geert Uytterhoeven wrote:
> Hi G=C3=BCnther,
>
> On Wed, Aug 20, 2014 at 2:45 AM, Guenter Roeck <linux@roeck-us.net> w=
rote:
>> Implementing a restart handler in a module don't make sense
>> as there would be no guarantee that the module is loaded when
>> a restart is needed. Unexport arm_pm_restart to ensure that
>> no one gets the idea to do it anyway.
>
> Why not? I was just going to do that, but I got greeted by:
>

Because you should register a restart handler instead, like the other
drivers in the same directory now do.

> ERROR: "arm_pm_restart" [drivers/power/reset/rmobile-reset.ko] undefi=
ned!
>
> So now we have to make sure all reset drivers for a zillion different
> hardware devices are builtin, and can't be modular?
>
No. All those drivers need to do is to register a restart handler using
the API provided in the patch series.

Ultimately all restart handlers should do that and arm_pm_restart shoul=
d
go away entirely. That was the point of the patch series.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

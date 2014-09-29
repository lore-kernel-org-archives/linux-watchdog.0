Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:49227 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaI2KnD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Sep 2014 06:43:03 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so2830547obc.28
        for <linux-watchdog@vger.kernel.org>; Mon, 29 Sep 2014 03:43:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43154094.zHJetoiMJ3@wuerfel>
References: <1411232812-11594-1-git-send-email-carlo@caione.org>
	<1411232812-11594-4-git-send-email-carlo@caione.org>
	<CAOQ7t2Z9LBmsYRRdutAnsmK-VN58XjiS9i1m-HC7T8Aku_tBQg@mail.gmail.com>
	<43154094.zHJetoiMJ3@wuerfel>
Date: Mon, 29 Sep 2014 12:43:01 +0200
Message-ID: <CAOQ7t2b-P6YMiQ64iWfYojLVXVTphCF3ZKGgq4VkvkBpTi7USg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ARM: DTS: meson: update DTSI to add watchdog node
From: Carlo Caione <carlo@caione.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Carlo Caione <carlo@caione.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org,
	Victor Wan <victor.wan@amlogic.com>,
	Beniamino Galvani <b.galvani@gmail.com>, wim@iguana.be,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 26, 2014 at 11:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 September 2014 10:04:45 Carlo Caione wrote:
>> Hi Arnd and Guenter,
>> who is supposed to take in this patch? The basic support for the SoC
>> is already in the arm-soc tree (thanks Arnd) and the other three
>> patches of this patchset are going in through Guenter tree (thanks
>> Guenter).
>>
>
> It should go through the arm-soc tree.

Arnd,
do you want me to submit a standalone patch for this?

Thanks,

-- 
Carlo Caione

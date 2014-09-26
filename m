Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:54190 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbaIZJ0L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Sep 2014 05:26:11 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so6643944obc.18
        for <linux-watchdog@vger.kernel.org>; Fri, 26 Sep 2014 02:26:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43154094.zHJetoiMJ3@wuerfel>
References: <1411232812-11594-1-git-send-email-carlo@caione.org>
	<1411232812-11594-4-git-send-email-carlo@caione.org>
	<CAOQ7t2Z9LBmsYRRdutAnsmK-VN58XjiS9i1m-HC7T8Aku_tBQg@mail.gmail.com>
	<43154094.zHJetoiMJ3@wuerfel>
Date: Fri, 26 Sep 2014 11:26:10 +0200
Message-ID: <CAOQ7t2abP=fVK9atW0E70_u2pBENxe1qLA9jhUCzkQbJrZag0w@mail.gmail.com>
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

Could you take it?

Thanks,

-- 
Carlo Caione

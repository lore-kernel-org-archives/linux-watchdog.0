Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:60082 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbaHUEMk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Aug 2014 00:12:40 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so10014302vcb.7
        for <linux-watchdog@vger.kernel.org>; Wed, 20 Aug 2014 21:12:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1408495538-27480-9-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
	<1408495538-27480-9-git-send-email-linux@roeck-us.net>
Date: Wed, 20 Aug 2014 21:12:39 -0700
Message-ID: <CAD=FV=Ub6ygGnHX7g422+LS=CS-09okQZ-YA-wfz=JdvwgJfkA@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
From: Doug Anderson <dianders@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Tomasz Figa <t.figa@samsung.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Implementing a restart handler in a module don't make sense
> as there would be no guarantee that the module is loaded when
> a restart is needed. Unexport arm_pm_restart to ensure that
> no one gets the idea to do it anyway.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: No change
> v6: No change
> v5: No change
> v4: No change
> v3: No change
> v2: No change
>
>  arch/arm/kernel/process.c   | 1 -
>  arch/arm64/kernel/process.c | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

(FYI: all patches tested by me were tested on rk3288-evb)

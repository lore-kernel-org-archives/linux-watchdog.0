Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55041 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbaIXSlu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Sep 2014 14:41:50 -0400
Received: by mail-ie0-f177.google.com with SMTP id x19so12025843ier.22
        for <linux-watchdog@vger.kernel.org>; Wed, 24 Sep 2014 11:41:49 -0700 (PDT)
Date: Wed, 24 Sep 2014 19:41:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bryan Wu <cooloney@gmail.com>,
	Andreas Werner <andreas.werner@men.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	"rpurdie@rpsys.net" <rpurdie@rpsys.net>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v6 0/4] Introduce MEN 14F021P00 BMC driver series
Message-ID: <20140924184143.GC7113@lee--X1>
References: <cover.1409161615.git.andreas.werner@men.de>
 <20140924144829.GK32069@lee--X1>
 <20140924154503.GA12403@roeck-us.net>
 <20140924161837.GA7113@lee--X1>
 <CAK5ve-+79oMf0vD-_gzWLPbvFi4ygd1q9pzTCHzzpsXVkjqP9Q@mail.gmail.com>
 <20140924165739.GA31578@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140924165739.GA31578@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 24 Sep 2014, Guenter Roeck wrote:

> On Wed, Sep 24, 2014 at 09:33:32AM -0700, Bryan Wu wrote:
> > On Wed, Sep 24, 2014 at 9:18 AM, Lee Jones <lee.jones@linaro.org> w=
rote:
> > > On Wed, 24 Sep 2014, Guenter Roeck wrote:
> > >
> > >> On Wed, Sep 24, 2014 at 03:48:29PM +0100, Lee Jones wrote:
> > >> > Guenter, Bryan, Wim,
> > >> >
> > >> > The following changes since commit 52addcf9d6669fa439387610bc6=
5c92fa0980cef:
> > >> >
> > >> >   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
> > >> >
> > >> > are available in the git repository at:
> > >> >
> > >> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ta=
gs/mfd-hwmon-leds-watchdog-v3.18
> > >> >
> > >> > for you to fetch changes up to 964356938fcd3c0001a786f55b9f0a0=
fbe47656a:
> > >> >
> > >> >   hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver (=
2014-09-24 15:36:33 +0100)
> > >> >
> > >> > --------------------------------------------------------------=
--
> > >> > Immutable branch between MFD, HWMON, LEDs and Watchdog for v3.=
18
> > >> >
> > >> I assume you'll push it all through mfd, correct ?
> > >
> > > The idea is for all the affected Maintainers to pull this branch =
in to
> > > their own trees.  If you guys don't, there will be a good chance =
of
> > > conflict during the merge-window, which will subsequently upset L=
inus.
> > >
> > > So in answer to your question; yes I'll be taking this, but so sh=
ould
> > > each of you.
> > >
> >=20
> > Thanks for this, man. What am I going to do here? Need I pull in al=
l
> > the patches here into my LED tree or just one LED patch? I think if
> > you push this for Linus through MFD tree, I don't need to pull it i=
nto
> > my tree, right?
> >=20
> I did
>=20
> git remote add mfd git://git.kernel.org/pub/scm/linux/kernel/git/lee/=
mfd.git
> git fetch --tags mfd
> git merge mfd-hwmon-leds-watchdog-v3.18
>=20
> in both my hwmon-next and watchdog-next branches. Both are currently =
building,
> and already pushed into to my repository at kernel.org.
>=20
> So, effectively, when I send my pull request to Linus, all patches fr=
om
> mfd-hwmon-leds-watchdog-v3.18 will be included, ie the entire series.
> The same will happen when Lee sends his pull request, and Wim, and yo=
u.=20
> I believe that is what Lee is asking for.

That's right.  It's not okay to break this branch up.  If it was, we
would have been able to apply our respective components into our own
trees from the beginning, but as there are interdependencies, breaking
up the branch could have nasty consequences depending on the order in
which they land in Mainline.  Most likely bisectability will be
broken, which is not allowed.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

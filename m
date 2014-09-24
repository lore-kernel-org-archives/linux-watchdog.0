Return-path: <lm-sensors-bounces@lm-sensors.org>
Date: Wed, 24 Sep 2014 09:57:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bryan Wu <cooloney@gmail.com>
Message-ID: <20140924165739.GA31578@roeck-us.net>
References: <cover.1409161615.git.andreas.werner@men.de>
	<20140924144829.GK32069@lee--X1>
	<20140924154503.GA12403@roeck-us.net>
	<20140924161837.GA7113@lee--X1>
	<CAK5ve-+79oMf0vD-_gzWLPbvFi4ygd1q9pzTCHzzpsXVkjqP9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK5ve-+79oMf0vD-_gzWLPbvFi4ygd1q9pzTCHzzpsXVkjqP9Q@mail.gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Andreas Werner <andreas.werner@men.de>,
	lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org,
	wim@iguana.be, "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
	Lee Jones <lee.jones@linaro.org>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [lm-sensors] [PATCH v6 0/4] Introduce MEN 14F021P00 BMC driver
	series
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/options/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors/>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 24, 2014 at 09:33:32AM -0700, Bryan Wu wrote:
> On Wed, Sep 24, 2014 at 9:18 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 24 Sep 2014, Guenter Roeck wrote:
> >
> >> On Wed, Sep 24, 2014 at 03:48:29PM +0100, Lee Jones wrote:
> >> > Guenter, Bryan, Wim,
> >> >
> >> > The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
> >> >
> >> >   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-hwmon-leds-watchdog-v3.18
> >> >
> >> > for you to fetch changes up to 964356938fcd3c0001a786f55b9f0a0fbe47656a:
> >> >
> >> >   hwmon: (menf21bmc) Introduce MEN14F021P00 BMC HWMON driver (2014-09-24 15:36:33 +0100)
> >> >
> >> > ----------------------------------------------------------------
> >> > Immutable branch between MFD, HWMON, LEDs and Watchdog for v3.18
> >> >
> >> I assume you'll push it all through mfd, correct ?
> >
> > The idea is for all the affected Maintainers to pull this branch in to
> > their own trees.  If you guys don't, there will be a good chance of
> > conflict during the merge-window, which will subsequently upset Linus.
> >
> > So in answer to your question; yes I'll be taking this, but so should
> > each of you.
> >
> 
> Thanks for this, man. What am I going to do here? Need I pull in all
> the patches here into my LED tree or just one LED patch? I think if
> you push this for Linus through MFD tree, I don't need to pull it into
> my tree, right?
> 
I did

git remote add mfd git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
git fetch --tags mfd
git merge mfd-hwmon-leds-watchdog-v3.18

in both my hwmon-next and watchdog-next branches. Both are currently building,
and already pushed into to my repository at kernel.org.

So, effectively, when I send my pull request to Linus, all patches from
mfd-hwmon-leds-watchdog-v3.18 will be included, ie the entire series.
The same will happen when Lee sends his pull request, and Wim, and you. 
I believe that is what Lee is asking for.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

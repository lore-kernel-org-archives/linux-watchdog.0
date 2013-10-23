Return-Path: <Johannes.Thumshirn@men.de>
Return-Path: <Johannes.Thumshirn@men.de>
Date: Wed, 23 Oct 2013 08:57:59 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: [GIT PULL v2] watchdog updates for Linux 3.13
Message-ID: <20131023065759.GA24193@jtlinux>
References: <20131023003541.GA2435@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20131023003541.GA2435@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Oct 22, 2013 at 05:35:41PM -0700, Guenter Roeck wrote:
> * PGP Signed by an unknown key
>
> Hi Wim,
>
> This is v2 of my pull request. Please ignore the previous request.
> There are a couple of changes as outlined below, and I rebased the
> branch to 3.12-rc6.
>
> Please consider pulling watchdog updates for Linux 3.13 from signed tag:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim
>
> The tag has been applied on top of the watchdog-next branch. The branch includes
> a number of patches I collected over the last few months. It does not include
> all submitted patches; only the ones I reviewed and felt comfortable with are
> included.
>
> I reviewed all patches and ran build tests as well as source verification tests
> with both smatch and spatch. The branch has been on my Linux repo for a while,
> so presumably Fenguang's robot will have built the code as well.
> The w83627hf patches have been running on several servers for more than a month
> without problems.
>
> You can find the most recent build results at
> http://server.roeck-us.net:8010/builders/watchdog-next.
>
> If you don't want to apply the entire series, please consider applying whatever
> subset you might feel comfortable with.
>
> Thanks,
> Guenter
>
> ------

Hi Gunther,

Can you please drop the patch from me from the pull request?  I'm afraid
something went wrong there, I thought Stephen Warren and I decided to just move
the binding document and not change the bindings, as the driver went upstream in
3.11.

But somehow I can't find his mail in the list archives. Maybe he accidently sent
it to me directly (and of cause I've already deleted it :-(, sorry ).

Should I re-send the move-patch, which was acked by Stephen? Or do you still
have it in an inbox?

Thanks a lot,
Johannes

Return-Path: <linus971@gmail.com>
Return-path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180207104207.GA25825@infomag.iguana.be>
References: <20180207104207.GA25825@infomag.iguana.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 12:02:33 -0800
Message-ID: <CA+55aFzrcAgOykaLK6S34W-udn5Y0rAC6j39MEZFz9CRSSnpEw@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.16 merge window
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
	Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Christophe Leroy <christophe.leroy@c-s.fr>, Corentin Labbe <clabbe@baylibre.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>, David Lechner <david@lechnology.com>,
	Eric Long <eric.long@spreadtrum.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>, Jerry Hoemann <jerry.hoemann@hpe.com>,
	Linus Walleij <linus.walleij@linaro.org>, Martin Kaiser <martin@kaiser.cx>,
	Mathieu Malaterre <malat@debian.org>, Matt Redfearn <matt.redfearn@mips.com>,
	Michael Grzeschik <mgr@pengutronix.de>, Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Radu Rendec <rrendec@arista.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Feb 7, 2018 at 2:42 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
>
> Please pull the watchdog updates for v4.16 from the following signed tag
>         git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-4.16-rc1

Thanks, pulled, since this now had the tag name and the description.

Two small further requests for next time:

> The output from git request-pull:

This was still broken, and didn't actually have the tag name. Notice this part:

> are available in the git repository at:
>
>   git://www.linux-watchdog.org/linux-watchdog.git

just points to the bare repo. And since that's the part my eyes are
trained to cut-and-paste (because this matches the normal pull request
format), I got it wrong at first before correcting my pull..

The other request is to just make your gpg key public, and hoipefully
get a few signatures for the future. I have your key since you sent it
to me in email separately, but nobody else can verify it since it
doesn't seem to be on any key servers.

So just a

    gpg --send-keys FA2CAD78625F46CA

should fix it for you. At which point maybe you can find somebody to
sign it because they can verify it (locally or perhaps over the phone
or other side channel).

                Linus

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:40734 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbaAUJTx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:19:53 -0500
MIME-Version: 1.0
In-Reply-To: <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
Date: Tue, 21 Jan 2014 07:19:52 -0200
Message-ID: <CAOMZO5BKjpkjQGOOAQ5fwmxhg1SYTmTq4Y9tUCZaDSQiosGYyw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared registers
From: Fabio Estevam <festevam@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 7:12 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Since the timer control register is shared with the clocksource driver,
> use the recently introduced atomic_io_clear_set() to access such register.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index f7722a4..cf64510 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -61,8 +61,6 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
>
>  static int orion_wdt_start(struct watchdog_device *wdt_dev)
>  {
> -       u32 reg;
> -
>         spin_lock(&wdt_lock);

Shouldn't this spin_lock be dropped now?

Regards,

Fabio Estevam

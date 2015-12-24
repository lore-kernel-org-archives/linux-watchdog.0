Return-path: <damien.riegel@savoirfairelinux.com>
Date: Thu, 24 Dec 2015 10:07:46 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] watchdog: Do not use 'dev' from watchdog_device in
 watchdog drivers
Message-ID: <20151224150744.GA6463@localhost>
References: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Dec 23, 2015 at 09:11:28PM -0800, Guenter Roeck wrote:
> The 'dev' variable in watchdog drivers has a different lifetime than the
> watchdog character device and should therefore not be used by watchdog
> drivers.
> 
> Some of the drivers use the variable to print kernel messages. Those are
> either dropped or converted to use pr_ functions. One driver sets the
> variable during initialization to the watchdog driver's parent device,
> which is wrong and also removed.

Hi Guenter,

For gpio_wdt and mena21_wdt, wdd->parent is set and could be used for
dev_* printings. Do you prefer to keep this variable only for watchdog
core internal usage? Otherwise, the serie looks good.

Thanks,
Damien

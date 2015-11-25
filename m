Return-path: <damien.riegel@savoirfairelinux.com>
Date: Wed, 25 Nov 2015 12:09:11 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 1/2] watchdog: core: call device_destroy before
 watchdog_dev_unregister
Message-ID: <20151125170910.GA6095@localhost>
References: <1448408745-26719-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <56551ADB.3000107@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56551ADB.3000107@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Nov 24, 2015 at 06:20:11PM -0800, Guenter Roeck wrote:
> On 11/24/2015 03:45 PM, Damien Riegel wrote:
> >device_create is called after watchdog_dev_register, so it makes more
> >sense to call the cleanup functions in reverse order, ie. device_destroy
> >before watchdog_dev_unregister.
> >
> >Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

On second thought, I am wondering if the proper fix would not be to call
device_create before watchdog_dev_register. Consider the following
scenario:

  watchdog_register_device
    __watchdog_register_device
	  watchdog_dev_register returns successfully, char dev is live
      device_create fails, setting wdd->dev to an ERR_PTR
	  ...
	  meanwhile, a user opens the watchdog, hence ops->start is called.
	  If ops->start uses wdd->dev (to print a debug message for
	  instance), it will dereference an invalid pointer.

Admittedly, it should be quite rare, but there is still a chance for a
race condition here.

Damien

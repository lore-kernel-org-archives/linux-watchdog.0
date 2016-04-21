Return-path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 21 Apr 2016 15:50:55 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Clemens Gruber
 <clemens.gruber@pqgruber.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: core: Fix circular locking dependency
Message-ID: <20160421155055.503e6d23@lxorguk.ukuu.org.uk>
In-Reply-To: <1461249494-24924-1-git-send-email-linux@roeck-us.net>
References: <1461249494-24924-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

> Turns out the call to cancel_delayed_work_sync() in watchdog_release()
> is not necessary and can be dropped. If the worker is no longer necessary,
> the subsequent call to watchdog_update_worker() will cancel it. If it is
> already running, it won't do anything, since the worker function checks
> if it needs to ping the watchdog or not.

Is this actually true. Consider the pathalogical case of the device being
closed and the modue unloaded. In that case the close completes, we drop
the module count but could still do work on it.

Alan

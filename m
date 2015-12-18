Return-path: <gnomes@lxorguk.ukuu.org.uk>
Date: Fri, 18 Dec 2015 17:19:39 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Alexander
 Usyskin <alexander.usyskin@intel.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v2 7/7] watchdog: mei_wdt: re-register device
 on event
Message-ID: <20151218171939.57bf5621@lxorguk.ukuu.org.uk>
In-Reply-To: <56743CD9.3000708@roeck-us.net>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
	<1450363780-30008-8-git-send-email-tomas.winkler@intel.com>
	<56743CD9.3000708@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

> I am not really happy about the watchdog device appearing and disappearing
> dynamically. This wreaks havoc with any standard watchdog application.

Any software that doesn't handle this has been broken for over fifteen
years. We have hotplug PCI and we have PCI watchdog card support. This
isn't a new behaviour to anyone outside the embedded single board space.

> Isn't there a better way to handle this ? How about just registering the
> watchdog device and return an error in the access functions if it is disabled ?

That breaks the existing behaviour of hot pluggable watchdog interfaces
and is different to just about any other device in the kernel. Today with
any desktop or server distribution you can already trivially arrange for
watchdog daemons to start at the point a watchdog is detected dynamically.

Alan

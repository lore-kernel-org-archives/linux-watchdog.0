Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36948 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbbLRRuT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 18 Dec 2015 12:50:19 -0500
Subject: Re: [char-misc-next v2 7/7] watchdog: mei_wdt: re-register device on
 event
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-8-git-send-email-tomas.winkler@intel.com>
 <56743CD9.3000708@roeck-us.net> <20151218171939.57bf5621@lxorguk.ukuu.org.uk>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56744757.2060101@roeck-us.net>
Date: Fri, 18 Dec 2015 09:50:15 -0800
MIME-Version: 1.0
In-Reply-To: <20151218171939.57bf5621@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/18/2015 09:19 AM, One Thousand Gnomes wrote:
>> I am not really happy about the watchdog device appearing and disappearing
>> dynamically. This wreaks havoc with any standard watchdog application.
>
> Any software that doesn't handle this has been broken for over fifteen
> years. We have hotplug PCI and we have PCI watchdog card support. This
> isn't a new behaviour to anyone outside the embedded single board space.
>
>> Isn't there a better way to handle this ? How about just registering the
>> watchdog device and return an error in the access functions if it is disabled ?
>
> That breaks the existing behaviour of hot pluggable watchdog interfaces
> and is different to just about any other device in the kernel. Today with
> any desktop or server distribution you can already trivially arrange for
> watchdog daemons to start at the point a watchdog is detected dynamically.
>

Ok, you have a point. Wonder if any distributions are doing that, though.
Any idea ?

Guenter


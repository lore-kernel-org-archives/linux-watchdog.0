Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53041 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab1FSL27 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Jun 2011 07:28:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/10 v2] Generic Watchdog Timer Driver
Date: Sun, 19 Jun 2011 13:28:40 +0200
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
References: <20110618172727.GJ3441@infomag.iguana.be> <201106182117.49026.arnd@arndb.de> <20110619110141.1ac221f1@lxorguk.ukuu.org.uk>
In-Reply-To: <20110619110141.1ac221f1@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106191328.40602.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sunday 19 June 2011 12:01:41 Alan Cox wrote:
> > Hmm, I'm not sure about this one. It does make the conversion
> > of existing drivers easier but doesn't encourage doing a good
> > job there.
> 
> It's not ultimately about conversion. A lot of watchdogs have interfaces
> that are not quite generic, extra requirements and custom interfaces. The
> ioctl interface is needed for that, not for conversions.

It's probably fine to have additional custom interfaces in some watchdogs
where needed, but do you think we also need to give drivers a way to
override the common ones?

If a driver has a different interpretation of a common command, I would
consider that a bug, not a driver specific extension. I would also
like to see the proper extensions easily visible, so we can create
new common interfaces in cases where multiple drivers have the same
requirement.

	Arnd

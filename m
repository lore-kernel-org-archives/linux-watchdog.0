Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56183 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbbLRSPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 18 Dec 2015 13:15:07 -0500
Date: Fri, 18 Dec 2015 18:14:12 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v2 7/7] watchdog: mei_wdt: re-register device
 on event
Message-ID: <20151218181412.49357bfe@lxorguk.ukuu.org.uk>
In-Reply-To: <56744757.2060101@roeck-us.net>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
	<1450363780-30008-8-git-send-email-tomas.winkler@intel.com>
	<56743CD9.3000708@roeck-us.net>
	<20151218171939.57bf5621@lxorguk.ukuu.org.uk>
	<56744757.2060101@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > That breaks the existing behaviour of hot pluggable watchdog interfaces
> > and is different to just about any other device in the kernel. Today with
> > any desktop or server distribution you can already trivially arrange for
> > watchdog daemons to start at the point a watchdog is detected dynamically.
> >
> 
> Ok, you have a point. Wonder if any distributions are doing that, though.
> Any idea ?

I don't know for any of the out of the box mainstream ones.

There is a second problem if you register the watchdog but don't actually
have it enabled. Consider the case where a user has the mei watchdog
disabled and a more advanced watchdog card plugged in - in that case the
naïvely implemented existing watchdog app may bind to the non-functional
watchdog, not the correct one.

Alan

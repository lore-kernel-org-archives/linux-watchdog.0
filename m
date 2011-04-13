Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42782 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758010Ab1DMJ3z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Apr 2011 05:29:55 -0400
Date: Wed, 13 Apr 2011 10:29:47 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Nat Gurumoorthy <natg@google.com>,
	Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 1/2] Use "request_muxed_region" in it87 watchdog
 drivers
Message-ID: <20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
In-Reply-To: <20110413070259.GE4070@infomag.iguana.be>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<20110413070259.GE4070@infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 13 Apr 2011 09:03:00 +0200
Wim Van Sebroeck <wim@iguana.be> wrote:

> Hi Nat,
> 
> > +	(void) request_muxed_region(REG, 2, NAME);
> 
> Why do we need to typecast this? Can't we just use 
> +	request_muxed_region(REG, 2, NAME);

We really ought to use

	if ()

in theory the request can fail if someone has hogged the resource and not
muxed it. I'm not clear what the right thing to do in that case is -
given it should never happen I guess log an error and bail out but that's
a rather bigger change and perhaps should be a follow up patch ?

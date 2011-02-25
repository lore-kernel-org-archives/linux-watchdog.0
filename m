Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:46727 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932415Ab1BYJ7c (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Feb 2011 04:59:32 -0500
Date: Fri, 25 Feb 2011 10:59:29 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jamie Iles <jamie@jamieiles.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH 2/10] Generic Watchdog Timer Driver
Message-ID: <20110225095929.GR3790@infomag.iguana.be>
References: <20110223204228.GA7369@infomag.iguana.be> <20110224094922.GB15118@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110224094922.GB15118@pulham.picochip.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jamie,

> It looks like the actual addition of .status to watchdog_ops happens in 
> the next patch rather than this one.

Correct. Fixed this in my code.

Thanks,
Wim.


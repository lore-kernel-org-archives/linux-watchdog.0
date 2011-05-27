Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:44534 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540Ab1E0IXP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2011 04:23:15 -0400
Date: Fri, 27 May 2011 10:23:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-watchdog@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Jamie Iles <jamie@jamieiles.com>,
	Walter Goossens <waltergoossens@home.nl>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	nios2-dev@sopc.et.ntust.edu.tw
Subject: Re: [PATCH v3 RESEND] watchdog: Add driver for Altera Watchdog
	Timer
Message-ID: <20110527082309.GB16394@infomag.iguana.be>
References: <1300461573-12268-1-git-send-email-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1300461573-12268-1-git-send-email-tklauser@distanz.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tobias,

> This driver adds support for the Altera Timer in the Watchdog Timer
> configuration. This component is usually found on SOPC (System on
> Programmable Chip) for Altera FPGAs.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca> (for the devicetree binding)

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

I presume this will go in together with the other nios2 architecture patches?

I presume this will go in together with the other nios2 architecture patches?

Kind regards,
Wim.


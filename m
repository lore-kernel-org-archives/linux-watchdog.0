Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:33435 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754227Ab0IJJDD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Sep 2010 05:03:03 -0400
Date: Fri, 10 Sep 2010 11:03:01 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Giel van Schijndel <me@mortis.eu>
Cc: Lutz Ballaschke <vegan.grindcore@googlemail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add f71862fg support
Message-ID: <20100910090301.GS354@infomag.iguana.be>
References: <20100906132434.GA17730@kreios.titan> <20100907131837.GH6114@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100907131837.GH6114@salidar.me.mortis.eu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> Given that the F71862 has *two* pins assignable to the WDTRST# signal,
> please document that fact, and the reason for choosing this one in the
> code.
> 
> Perhaps it might even be desirable to insert a printk there.  This to
> make the user aware of the fact that this driver might not work if the
> pin configuration of their hardware doesn't match the assumption you
> make about it in this code.

I propose to Document it in the code and add a module-parameter so that it is selectable.

Kind regards,
Wim.


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51342 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab1AFLPg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Jan 2011 06:15:36 -0500
Received: by wyb28 with SMTP id 28so16281393wyb.19
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Jan 2011 03:15:34 -0800 (PST)
Date: Thu, 6 Jan 2011 11:15:30 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: John Crispin <blogic@openwrt.org>
Cc: Jamie Iles <jamie@jamieiles.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110106111530.GD2946@pulham.picochip.com>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
 <1294257379-417-6-git-send-email-blogic@openwrt.org>
 <20110105234910.GD2112@gallagher>
 <4D25908E.9070509@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D25908E.9070509@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 06, 2011 at 10:51:10AM +0100, John Crispin wrote:
> On 06/01/11 00:49, Jamie Iles wrote:
> > I think you need a clk_put() here too to balance the clk_get() in the 
> > probe method so you'll need to keep a reference to the clk.
> >
> >   
> 
> Hi Jamie,
> 
> i will fold your suggestions into the series.
> 
> the clk.c/h implementation on the lantiq target is very simple. it only
> allows to read the static rates of the 3 clocks. clk_put is implemented
> as follows
> 
> void
> clk_put(struct clk *clk)
> {
>     /* not used */
> }
> EXPORT_SYMBOL(clk_put);
> 
> so in theory you are right and we should call that function, however as
> it is only a stub and the driver is only used by the lantiq target i
> think it is save to leave out the clk_put(); call. we could however put
> a commet in the code to make this clear (same as with the clk_enable()
> not being needed as the clocks are always running)

Could that ever change for future devices that share the same watchdog 
block?  If so, then adding in that clk_put() and clk_enable() might be 
worth it as it doesn't cost much.

Jamie

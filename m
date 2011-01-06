Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:41426 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab1AFJuJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Jan 2011 04:50:09 -0500
Message-ID: <4D25908E.9070509@openwrt.org>
Date: Thu, 06 Jan 2011 10:51:10 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Jamie Iles <jamie@jamieiles.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: lantiq: add watchdog support
References: <1294257379-417-1-git-send-email-blogic@openwrt.org> <1294257379-417-6-git-send-email-blogic@openwrt.org> <20110105234910.GD2112@gallagher>
In-Reply-To: <20110105234910.GD2112@gallagher>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/01/11 00:49, Jamie Iles wrote:
> I think you need a clk_put() here too to balance the clk_get() in the 
> probe method so you'll need to keep a reference to the clk.
>
>   

Hi Jamie,

i will fold your suggestions into the series.

the clk.c/h implementation on the lantiq target is very simple. it only
allows to read the static rates of the 3 clocks. clk_put is implemented
as follows

void
clk_put(struct clk *clk)
{
    /* not used */
}
EXPORT_SYMBOL(clk_put);

so in theory you are right and we should call that function, however as
it is only a stub and the driver is only used by the lantiq target i
think it is save to leave out the clk_put(); call. we could however put
a commet in the code to make this clear (same as with the clk_enable()
not being needed as the clocks are always running)

Thanks,
John


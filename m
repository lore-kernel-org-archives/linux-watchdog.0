Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61794 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab1EZNi7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 May 2011 09:38:59 -0400
Received: by wwa36 with SMTP id 36so780669wwa.1
        for <linux-watchdog@vger.kernel.org>; Thu, 26 May 2011 06:38:58 -0700 (PDT)
Date: Thu, 26 May 2011 14:38:54 +0100
From: Jamie Iles <jamie@jamieiles.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCHv6] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110526133854.GE2577@pulham.picochip.com>
References: <1295871552-22254-1-git-send-email-jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295871552-22254-1-git-send-email-jamie@jamieiles.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Mon, Jan 24, 2011 at 12:19:12PM +0000, Jamie Iles wrote:
> The Synopsys DesignWare watchdog is found in several ARM based systems
> and provides a choice of 16 timeout periods depending on the clock
> input.  The watchdog cannot be disabled once started.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Apologies for not chasing this sooner, is this driver OK to be applied?  
This should apply cleanly onto 2.6.39.

Jamie

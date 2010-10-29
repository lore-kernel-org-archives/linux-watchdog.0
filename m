Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:5893 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934181Ab0J2RY5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Oct 2010 13:24:57 -0400
Date: Fri, 29 Oct 2010 19:24:55 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	robert.evans@stratus.com, robert.manchek@stratus.com,
	chas.horvath@stratus.com, jparadis@redhat.com
Subject: Re: [PATCH]: watchdog/iTCO: remove extra pci_dev_put()'s from init
	code
Message-ID: <20101029172455.GF4046@infomag.iguana.be>
References: <20101027135012.15174.8589.sendpatchset@prarit.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101027135012.15174.8589.sendpatchset@prarit.bos.redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Prarit,

> [Wim -- I'm not on the list so please cc me on any questions.  Also, I
> had pushed two previous iTCO_wdt patches to linux-watchdog but I do not
> see that they have been committed ... was there something wrong with them?

Sorry for the "radio" silence, but I had to finish an urgent project.

This patch (pci_dev_put) has been added yesterday evening.
The patch you sent in for the clarification of error messages has also been added (but with different identation so that it looks similar to the rest of the code). I did not keep you change of found++ to found = 1 in the same patch.

You are talking about 2 patches that you pushed before. I only saw the one about clarification of error messages. Could you resent the other one?)

Thanks in advance,
Wim.


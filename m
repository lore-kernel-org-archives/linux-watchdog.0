Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:31497 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753734Ab0LJNXT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Dec 2010 08:23:19 -0500
Date: Fri, 10 Dec 2010 14:23:16 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [WATCHDOG] fix compiler warning on ali_pci_tbl
Message-ID: <20101210132316.GB3783@infomag.iguana.be>
References: <1291739256-16380-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1291739256-16380-1-git-send-email-namhyung@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Kim,

> Annotate ali_pci_tbl as '__used' to fix following warning:
> 
>   CC      drivers/watchdog/alim1535_wdt.o
> drivers/watchdog/alim1535_wdt.c:304: warning: ‘ali_pci_tbl’ defined but not used
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Will be added to linux-2.6-watchdog-next.

Kind regards,
Wim.


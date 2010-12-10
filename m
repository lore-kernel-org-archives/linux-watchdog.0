Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:14431 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754324Ab0LJNXx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Dec 2010 08:23:53 -0500
Date: Fri, 10 Dec 2010 14:23:51 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [WATCHDOG] fix compiler warning on alim7101_pci_tbl
Message-ID: <20101210132351.GC3783@infomag.iguana.be>
References: <1291739256-16380-1-git-send-email-namhyung@gmail.com> <1291739256-16380-2-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1291739256-16380-2-git-send-email-namhyung@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Kim,

> Annotate alim7101_pci_tbl as '__used' to fix following warning:
> 
>   CC      drivers/watchdog/alim7101_wdt.o
> drivers/watchdog/alim7101_wdt.c:433: warning: ‘alim7101_pci_tbl’ defined but not used
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Will be added to linux-2.6-watchdog-next.

Kind regards,
Wim.


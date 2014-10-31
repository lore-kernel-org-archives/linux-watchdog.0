Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51825 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbaJaUui (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Oct 2014 16:50:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: at91: rm9200 add system timer resources to watchdog
Date: Fri, 31 Oct 2014 21:50:05 +0100
Message-ID: <3170633.12AsIiHlY5@wuerfel>
In-Reply-To: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 31 October 2014 21:45:58 Alexandre Belloni wrote:
> To be able to make the watchdog driver independent from the mach/ includes, pass
> the system timer register space as a resource.
> 
> Also, change the name to avoid conflicting with the at91sam9 watchdog driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 

Doing this change as a separate patch breaks bisection because now the device
name no longer matches untile the other patch is applied too.

	Arnd

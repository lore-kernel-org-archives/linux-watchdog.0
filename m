Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:62170 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab3JAEqB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Oct 2013 00:46:01 -0400
Message-ID: <524A5384.9060704@roeck-us.net>
Date: Mon, 30 Sep 2013 21:45:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org
CC: workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v6] watchdog: sirf: add watchdog driver of CSR SiRFprimaII
 and SiRFatlasVI
References: <1380550139-28796-1-git-send-email-Baohua.Song@csr.com>
In-Reply-To: <1380550139-28796-1-git-send-email-Baohua.Song@csr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/30/2013 07:08 AM, Barry Song wrote:
> From: Xianglong Du <Xianglong.Du@csr.com>
>
> On CSR SiRFprimaII and SiRFatlasVI, the 6th timer can act as a watchdog
> timer when the Watchdog mode is enabled.
>
> watchdog occur when TIMER watchdog counter matches the value software
> pre-set, when this event occurs, the effect is the same as the system
> software reset.
>
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Romain Izard <romain.izard.pro@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>



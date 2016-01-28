Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:34747 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcA1Wyb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Jan 2016 17:54:31 -0500
Message-ID: <56AA9BDF.6070907@oracle.com>
Date: Thu, 28 Jan 2016 14:53:19 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
MIME-Version: 1.0
To: Julian Calaby <julian.calaby@gmail.com>
CC: wim@iguana.be, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com> <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
In-Reply-To: <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/28/2016 02:50 PM, Julian Calaby wrote:
> Hi Wim,
>
> Sorry to keep iterating on this, but I noticed two small things you
> could improve:

yeah I was considering that although it makes the code a bit more 
readable but
fine happy to tweak that. no problem.

the static is definitely no longer needed after all the cleanup that 
happened.


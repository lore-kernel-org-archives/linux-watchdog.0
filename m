Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59572 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934401Ab3IDF5A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Sep 2013 01:57:00 -0400
Message-ID: <5226CBAA.10002@roeck-us.net>
Date: Tue, 03 Sep 2013 22:56:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matthew Garrett <matthew.garrett@nebula.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Thomas.Mingarelli@hp.com" <Thomas.Mingarelli@hp.com>,
	"toshi.kani@hp.com" <toshi.kani@hp.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 1/2] Move and rename HP watchdog timer driver
References: <1378272591-9755-1-git-send-email-matthew.garrett@nebula.com>  <5226C880.8010704@roeck-us.net> <1378273901.11730.53.camel@x230>
In-Reply-To: <1378273901.11730.53.camel@x230>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/03/2013 10:51 PM, Matthew Garrett wrote:
> On Tue, 2013-09-03 at 22:43 -0700, Guenter Roeck wrote:
>
>> If that is the case, wouldn't it make more sense to have separate drivers,
>> one per functionality, plus an mfd driver to bind them all together ?
>
> It'd be an option, but I don't think there's a huge benefit - the
> functionality's reasonably related and there's no real internal bus
> architecture on the device.
>
On the other side it is much cleaner. drivers/mfd/lpc_sch.c and drivers/mfd/lpc_ich.c
are good examples.

Guenter


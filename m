Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46377 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeH3SnG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Aug 2018 14:43:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so3973985pga.13
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Aug 2018 07:40:38 -0700 (PDT)
Date: Thu, 30 Aug 2018 07:40:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek Behun <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
Message-ID: <20180830144036.GA24117@roeck-us.net>
References: <20180830142243.12153-1-marek.behun@nic.cz>
 <20180830162828.356ca519@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830162828.356ca519@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 30, 2018 at 04:28:28PM +0200, Marek Behun wrote:
> Hi,
> 
> Checkpatch complains about not adding the new .c file to MAINTAINERS.
> As I am sending other patches to linux-gpio, which creates a new group
> in MAINTAINERS file, to which this file should belong, but if I created
> this group also here, it would result in a conflict.
> The addition of this file to MAINTAINERS will be done in the patch sent
> to linux-gpio. Is this ok, or shall I do it differently?
> Thanks.
> 
This is one of the checkpatch complains to ignore.

Guenter

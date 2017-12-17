Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39830 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757336AbdLQUcm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 17 Dec 2017 15:32:42 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v4.15 Fixes
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
References: <20171217105558.GA6260@infomag.iguana.be>
 <CAADWXX-_k5z=08P6sW_6xip+9SEyv+FmfCFFB2P+ux0=FDBeDw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ba3e337e-6442-b1fe-cab9-c0a863c35015@roeck-us.net>
Date: Sun, 17 Dec 2017 12:32:39 -0800
MIME-Version: 1.0
In-Reply-To: <CAADWXX-_k5z=08P6sW_6xip+9SEyv+FmfCFFB2P+ux0=FDBeDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/17/2017 12:12 PM, Linus Torvalds wrote:
> Once more, gmail hated you. No real indication why, apart from:
> 
>    Why is this message in Spam? We've found that lots of messages from
> iguana.be are spam.
> 
> I have no idea why that site is so hated, but one option that your
> upstream  ISP is some scumbag place that allows spammers and scammers
> and thus the addresses end up being on some blacklist.
> 
> Also, all of these commits were committed less than an hour before
> sending me the pull request, so I question the kind of testing they
> got..
> 

The patches have been in -next for a while, only Wim moved them
into a different branch to be able to send you a pull request.

In -next:

8e1828d605df watchdog: hpwdt: SMBIOS check
ee11fc2b6e73 watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
bff862153935 watchdog: Fix kref imbalance seen if handle_boot_enabled=0
01cd17d9fe08 watchdog: Fix potential kref imbalance when opening watchdog

You might as well blame me since I asked Wim to either send those patches
to you or to let me do it, and I would have pulled the patches from Wim's
watchdog-next repository (or from linux-next) as well.

Guenter

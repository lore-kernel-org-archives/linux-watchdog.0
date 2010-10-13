Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53883 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab0JMVDA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Oct 2010 17:03:00 -0400
Received: by gwj17 with SMTP id 17so2095669gwj.19
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Oct 2010 14:02:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1286997576-4988-1-git-send-email-timur@freescale.com>
References: <1286997576-4988-1-git-send-email-timur@freescale.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 13 Oct 2010 16:02:28 -0500
Message-ID: <AANLkTimTGwEzbSc2t=njs8rpLFS9azo1CgKAMd9Q27sE@mail.gmail.com>
Subject: Re: [PATCH] powerpc: change the Book-E watchdog driver default
 timeout into a Kconfig option
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 13, 2010 at 2:19 PM, Timur Tabi <timur@freescale.com> wrote:

> the value a Kconfig option allows BSPs to configure a new value with requiring

That should say, "without requiring"

-- 
Timur Tabi
Linux kernel developer at Freescale

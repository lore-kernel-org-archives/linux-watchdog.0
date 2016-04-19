Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55884 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbcDSHtj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Apr 2016 03:49:39 -0400
Message-ID: <1461051988.15527.6.camel@suse.com>
Subject: Re: [PATCH v2] watchdog: add driver for StreamLabs USB watchdog
 device
From: Oliver Neukum <oneukum@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Klimov <klimov.linux@gmail.com>, yury.norov@gmail.com,
	wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Date: Tue, 19 Apr 2016 09:46:28 +0200
In-Reply-To: <20160418163918.GE29343@roeck-us.net>
References: <1460948016-5453-1-git-send-email-klimov.linux@gmail.com>
	 <1460968368.25119.7.camel@suse.com> <5714E7D3.4030809@roeck-us.net>
	 <1460988518.25119.28.camel@suse.com> <20160418163918.GE29343@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2016-04-18 at 09:39 -0700, Guenter Roeck wrote:
> > Possibly. We have never gone that route. The obvious problems is
> that
> > I am not sure our alignment is known before boot.
> > 
> Seems scary. I always thought that the alignment associated with
> ____cacheline_aligned would be the maximum possible for a given
> build/architecture. If not, what is the value of having
> ____cacheline_aligned in the first place ?

I thought it was for performance to prevent cache bouncing.
I honestly don't know. You'd have to ask a specific question
on LKML.

	Sorry
		Oliver



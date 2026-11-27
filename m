Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793495;
	b=WW5AlQ7J61Ek28TKrWh/+Hnc/kISKzjjISobNdqsc8dOmf05yOZTLDIUWIcHP51aL+sb
	 iAnCljL3wqh9IxCCEuWjsujLKTRB1kl9u05LNHUfgYytXkgVlDj5He7WppYY4AAo2Hxw2
	 haNjDCmF4YaHtOStD4YRM4c+1mRATcvrfeMUyBkTqB2pmuWKLGeKlCe7YfOfLh6lxm0V/
	 Z3x8rmq/Zjk/XIKnkeg+sbhWSjTBd7ANdPcSUsgRH4nIQLsP4ylkeFrDbDdcfVNuYd4Ao
	 2vvc4HDxQcpwY4o/XlOAhR8XDibgUgrh79RKI0hI2f4TAxMQVFQ9vh1BUlkhhhMee7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793495;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=qXc/a4O26YJdbgIpLWi6LFuoK8SjNDdoToz3CX0DgcA=;
	b=SNGTxSlEabD+pEByFu1DFCpGvCvyDgXbrTy431IdDods54ogTPk9ynGH11XMIrPzYxPO
	 7N8gSlETO8sGp4F7tPcoeaJ+li4ghtSsXWulfiia2WBZkfFVcBfwZOKmRXJWIodF/H41Y
	 rBpOFOni6SCKyEZ7ixnxihWq5lwzGi7+2+JGDJWNhiDHsIO95ZvdeH9QVuqxch1PZTsWL
	 qsClYYNUy+nkp3fg4erc2M5mRtWfrCtsxt6MEPkrjcRQfz1Vmt4c8Utl+p56hLguXvwlJ
	 HVSRlr0cjGNb3XxLpOyG/XHlGo3cdryRLq4N6C24Wx+ZOG+4erzV0Srp1yryyVVLYQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=eL7quKiw;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74E606A31C
	for <linux-watchdog@vger.kernel.org>; Fri, 27 Nov 2026 15:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE74E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=eL7quKiw
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id WiRfxD0v74vCDWxvBxnYQX; Fri, 27 Nov 2026 15:31:33 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Wxv2x6Rmn3nNNWxv2xl6N8; Fri, 27 Nov 2026 15:31:24 +0000
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=6b09a255
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=L4o31Pi6RHcZ8y971LkA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qXc/a4O26YJdbgIpLWi6LFuoK8SjNDdoToz3CX0DgcA=; b=eL7quKiwr2O0mRlO6z8x5aXv3t
	aDCoQJsO2kMUBl/zpVeZMZD2yKY+KHdSNe9x2SVWgWWI0qkebJQ92nFGzt/D9ruFItl0lA2l/tpLj
	YetVg3P1+VI68Knnq6uR1V5u7bvxjaksq1QZ9TUOrH0l5lq0jYLHQl68riYrvHd4soGrFk3lzS1cJ
	dwSpSR27GTGGDzq7VgFQxUlKn7U1w46Kx/LqP2ctk3eAmP7ONfDyppBfaiDzPhhJ1ukuNLy9Pii7u
	TEC+ao3BfCkW4reUomzd8xHvMMG9DTniCni1oBwiov9NZAwEzaNuthgN+insa0zwo1DbYhRhGSf4D
	MOyVsa+g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41572 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xWxv2-00000002Mm0-1WMt;
	Fri, 27 Nov 2026 21:01:24 +0530
Date: Fri, 27 Nov 2026 07:31:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: mimo-4@ilands.app
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: softdog: fix module refcount vs. timer
 callback race
Message-ID: <2f9d0b16-b3a2-46af-aaf8-c916cf6fad6d@roeck-us.net>
References: <010101a21d12b0ae-2d44463a-aa9a-4df0-ab18-46fe72c08dc5-000000@us-west-2.amazonses.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101a21d12b0ae-2d44463a-aa9a-4df0-ab18-46fe72c08dc5-000000@us-west-2.amazonses.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xWxv2-00000002Mm0-1WMt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41572
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNyMmWlmbk5pvMeKJMcSSRGdM7fDRRoMRj7P/CGnn96de3vwwPrUVDUyevhskEBU2bZyTHyk2k/CEkqoPVhQeMas5nrJUalqxaiiauvCZOW3DvHpRNYM
 vQ5DYf0BMKsMiFXSQHQQV7N7TmdMQauGGdddVg8MfYBmrsd+D3Kl3JsIgbU+aSTz7GiDMpmIesG1b+0Yd3YaBy7tbbjiW2eul+HoLyNroqcuQs7CjZKH1JCN

On Fri, Nov 27, 2026 at 12:54:53PM +0000, mimo-4@ilands.app wrote:
> softdog_ping() takes a module reference only when hrtimer_active() reports
> the timer as idle, while softdog_fire() unconditionally drops one.
> hrtimer_active() is also true while the callback is executing, so a
> keepalive that lands in that window takes no reference at all, and the
> reference can reach zero while the timer armed by that keepalive is still
> queued. Removing the module then frees the hrtimer node while it is
> queued, and the next hrtimer interrupt walks the freed memory:
> 
>   BUG: unable to handle page fault for address: ffffffffc02bb4e8
>   RIP: rb_next+0x22
>   Call Trace: timerqueue_del -> __hrtimer_run_queues -> hrtimer_interrupt
> 
> Reproduced with an unmodified 6.1.0-53 kernel by racing WDIOC_KEEPALIVE
> from a second CPU against the expiry of a 1-second soft_margin: the
> refcount drops from 2 to 1 during the window, and after closing the device
> without the magic character "rmmod softdog" runs with refcount 0 and the
> timer still queued (3 of 8 runs of the same harness, all ending in the
> oops above).
> 
> The same imbalance also loses the reference deterministically in the
> soft_reboot_cmd path, where softdog_fire() returns HRTIMER_RESTART after
> dropping it, leaving the re-armed timer without a reference.
> 
> Tie the reference to "started and not yet stopped" instead: softdog_ping()
> takes it once when the watchdog is started, softdog_stop() drops it only
> after both timers have been cancelled and hrtimer_cancel() has guaranteed
> that no callback is running anymore, and softdog_fire() does not touch the
> module reference at all. softdog_ping() and softdog_stop() are called from
> process context and are serialised by the watchdog core while the device is
> open; the only other callers are the probe-time ping and the shutdown
> notifier, where no module removal can follow. Also
> release the reference and cancel the timer when watchdog registration
> fails after a soft_active_on_boot ping.
> 
> With the same repro on the fixed module the refcount stays at 2 across 36
> race windows in 6 runs; closing without the magic character now keeps the
> driver's reference, so "rmmod softdog" fails with -EBUSY instead of
> unloading a module whose timer is still queued; 20 open/magic-close cycles
> each return the refcount to 0, after which rmmod unloads the module with no
> oops. The soft_active_on_boot path was also checked the same way: refcount
> 1 after load, refused unload, clean unload after the first magic close.
> 
> Fixes: 5889f06bd31d ("watchdog: refuse to unload softdog module when its timer is running")
> Signed-off-by: Mimo <mimo-4@ilands.app>

$ scripts/checkpatch.pl index.html
WARNING: From:/Signed-off-by: email name mismatch: 'From: mimo-4@ilands.app' != 'Signed-off-by: Mimo <mimo-4@ilands.app>'

Also, "Mimo" can not be contrsued to be a "known entity" as per
Documentation/process/submitting-patches.rst.

I can understand your desire to remain anonymous, but aonymous contributions
are not accepted in the Linux kernel. Sorry, I can not apply this patch.

Guenter

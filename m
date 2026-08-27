Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B7383305
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850579; cv=none; b=bspaV9DnvBqCWYziSs20S1HdMNGUQ6utoe/IRastH6WpZrSXTAg2h3RvAo5F2WFdpSsWofxBc9gN5h6xFmh0oFF1K/a6oNbDChG74vpTUhv/5xdkRedWxUk+f1NMQTFM8yAg2eBWcMQAAkzz/1lY9qSCwKn6l96mUxcz94F6ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850579; c=relaxed/simple;
	bh=ab2ZLhXK2ZtzK1pxldMxYVte6a8fivRQLA8LoNYMtiw=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzdhF8ylkh/EQqqLtgQvrB2ILVB9uEaIQgf9O3joWhigaeKnVDBiXIvz6EGvldDRS9hJEG0prSsWhXkIr2suI8vXXuYxGcDcccZ8i91GQHgznmmneOeVlBoJOGKooz5dGSCrtngaR1SDzjPb7WeTcf6xq0RK3KQ4OOPWVyqgGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DitnIE4Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lLoqgyU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DitnIE4Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lLoqgyU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787850577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKHPpv93xvylGFEF20RemjGdz/fmhRpr/jVoce2dxu4=;
	b=DitnIE4YGe9n+EsXMB+tLOsoSERyh6o4iFfZKmdfYjP9kOTtymSP1g7KTn6v8bnXIaszyT
	xCtnZVw1FJGn9Uyx0sB3p/WXFkCxbgIxFbdm+QX97G5o8B4GdxXw+SlG01AFdpCy4at0QO
	nsDzdziD8nkfltBALTftlRmSOoQpvKo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-M6XVQDxrNFyxHpdQfiuGXA-1; Thu, 27 Aug 2026 13:09:35 -0400
X-MC-Unique: M6XVQDxrNFyxHpdQfiuGXA-1
X-Mimecast-MFC-AGG-ID: M6XVQDxrNFyxHpdQfiuGXA_1787850574
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f39a46efd9so12873486d6.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787850574; x=1788455374; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:cc:to
         :subject:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKHPpv93xvylGFEF20RemjGdz/fmhRpr/jVoce2dxu4=;
        b=lLoqgyU3DiepQ9wh17LkpmfvhoE5xPGhBVX2kG3Ma1aUJLNbMU20wnV3VxNhGOqmoY
         KXpL7qyLUf7/Cq3+Plrb0ADJCOiJm34L+wuOSpsKXAJbLedgLIF9CojadDl82uHrpyRM
         P2jTXsOB/D6DJMUvGWg7lOkp+3t+4D7N0D9Ml6z+ykdrZruxCVE0lh/xwrcm5ZsOSu0R
         3sJs+PMKoXepRv9CdtUAYDrTSMX0WS7FLWxGSnbj5Iscd9EsyOHiCR1gQ88EpYQGFLt3
         cCHdbCn3a1Pn+kUdJp86xDhQiWGZBToGvWjaDQ0CwRiZ2WxRLsG+og0EvhHlnMmSPVjJ
         RYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787850574; x=1788455374;
        h=content-type:mime-version:references:in-reply-to:message-id:cc:to
         :subject:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKHPpv93xvylGFEF20RemjGdz/fmhRpr/jVoce2dxu4=;
        b=kO9S6wc7K/o0WTi7BgwBZc0fCl4mOIniO5Cz8tKlIX56xHFFsnvXT2ojA+6aFrGGGH
         /4jtSi8wTbRtoyJiDKqhN4REtHKWHhYSSmdV/8WVHpX2XccvO0LLREdYSzn3UAbO58l/
         jMREEy8MMDz4DX4DNp9ae2h22IgjNgKn144quZlXBAJnaMx5LbQdUZuit160HNnr5yMH
         +y+xmC6I+la3cxqxfph/TLBDDz+ap8OEZv8HGzoCaKC1cDxXwtek6q8ez4ujRP0P/OHn
         5UFrXm2EDvP8Y/PE4yZLwzVpiQfSgOcQNXwl8D6ksfZXCzNIwR6PFYdvk0cE3umNIznB
         oncA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5tIPXXsxA4BrWFRUP135cswtQ+9or7HpLATVuAD0q2KmpMg/Ps/O3lHs5vr84PpMdIIh07YjaDpintQ+7SQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kkKBf+7F6atCOXxhAAx18PcPaQeFGvNfsQynvbsuGikPwSqUX6
	+TYu9xnS5uzsGQwbvThiOHrs450AdLJc5BskR/+3jfxV9XSM/3UhBiARwgg6dlIyQwwYhoc18d3
	cA32ysU62oEFgxiXcUEkFEE69idxd7VQffDm34mC6p2uhP9QEuih8J12fUPzdgZC9l9Nj
X-Gm-Gg: AR+sD11im+snEtJIjsIHcu5KVBZKFjJMcJRuPDrT0HKG2XKMxmhmTM4eiBTyi2SuMR9
	Xx/ueiB4Fki5u5QgfFdXWcBD7XoaBPW7zCoRBOWpWhAY7TVmHkqEMehAbGGUCZktLPAFXrOVlU7
	0GSvAOPvDckPcdfV40Ppw3ivMjrUUr8JNe7VVwdcNT8uTyQ7o3LpXtRkpaOl7lv16wJMuiPiY0S
	rQsDvm5R/aMVyw+WEif0EJoVp3r8DwC0EoVAJhqM1YbRaPoQZUds1UcXan3BOldVWa/knUM64Be
	o4mXnn/aJT/u7XIW697olTm/REqvxRoOb06hWJIIY1U6NtRyZKn4cvMieXmugJef+SljAMDZ28G
	skEmxJVnM5EmtkvO1jw7R9iRtA672hFKbOCadCC4YQGCtv0jlxwHAOIgb5pOf4JeaDpE=
X-Received: by 2002:a05:6214:3bc5:b0:8ee:756a:bc32 with SMTP id 6a1803df08f44-90ce0ede144mr8863206d6.15.1787850574223;
        Thu, 27 Aug 2026 10:09:34 -0700 (PDT)
X-Received: by 2002:a05:6214:3bc5:b0:8ee:756a:bc32 with SMTP id 6a1803df08f44-90ce0ede144mr8861956d6.15.1787850573595;
        Thu, 27 Aug 2026 10:09:33 -0700 (PDT)
Received: from [192.168.1.59] (184-96-189-144.hlrn.qwest.net. [184.96.189.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd7028a16sm21380456d6.13.2026.08.27.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:09:33 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:09:25 -0600
From: chaithco@redhat.com
Subject: Re: [PATCH] Differentiate scenarios when watchdog is closed
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <QBUFKT.6XP2A9BR6LRO3@redhat.com>
In-Reply-To: <2bd566ca-2696-46d3-aeec-57db66fa1902@roeck-us.net>
References: <20260824205051.4117285-2-chaithco@redhat.com>
	<2bd566ca-2696-46d3-aeec-57db66fa1902@roeck-us.net>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Thu, Aug 27 2026 at 09:01:47 AM -07:00:00, Guenter Roeck 
<linux@roeck-us.net> wrote:
> Presently
> [...]
> Also, the subject should start with the subsystem name ("watchdog:")
> [...]
> deliberately

Thank you for catching these! Please accept my apologies. I can fix 
those up in the next submission.

> [...] Also, while technically userspace may close the
> watchdog deliberately while it is running, that is not what happens
> on a regular basis.

This is actually what initiated a bug report at 
https://bugzilla.redhat.com/show_bug.cgi?id=1991285 it turns out 
systemd explicitly does this to help ensure a system shutting down 
actually eventually goes down even if the shutdown process hits some 
snags. It does this on every shutdown. Given the prevalence of systemd, 
this is a regular occurrence. The end result is that, when using iTCO, 
it shows an error on every shutdown when systemd is in use as init.

> If you want to make a change, I would suggest to add an error message
> into watchdog_stop() to report an error if the stop callback returns
> an error. That would distinguish 2/3 without making functional 
> changes.

Thank you! So something like this?

        if (wdd->ops->stop) {
                clear_bit(WDOG_HW_RUNNING, &wdd->status);
                err = wdd->ops->stop(wdd);
+               if (err < 0)
+                       pr_info("watchdog%d: closed while still 
enabled!\n");
                trace_watchdog_stop(wdd, err);
        } else {
                set_bit(WDOG_HW_RUNNING, &wdd->status);


While responding to this, an additional thought occurred to me; given 
the primary reason a user would see this is because systemd is shutting 
down a system, it may be more worth while to have systemd log something 
about closing the watchdog without disarming it to at least explain a 
pr_crit kernel log line. Otherwise, it just looks like "something bad 
happened" with watchdog. I am additionally unsure of what would be best 
to go in watchdog_stop that helps differentiate intentional closing of 
the watchdog without disabling vs malicious/accidental closing. The 
intent would lie within the entity closing the watchdog; "closed while 
still enabled!" still seems like "something bad happened" with info on 
if it was intentional or not.

Thank you!
- Charles



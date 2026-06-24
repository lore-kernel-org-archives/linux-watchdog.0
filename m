Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59353C0A07;
	Wed, 24 Jun 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310899; cv=none; b=KxM7d2iL22DQRXNvMpJmzl/H1vOe+3k+jKoWS9ZWE+YWbpCEeezjwlwXJjtUMBF/Czxx3o0ecOHGtiiAAXIIxJc00BVMRn8dK70jyElHgyesta6Tuu73s3ze0sTDAku2XAXwiJxkrDGyNSSFfosbrJrVUra6GuoDxkoNriJOUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310899; c=relaxed/simple;
	bh=uJuWsywmUFOfg0MdeKQPGehCr55f+fyLju8cg6hud48=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iNfRn5DaQ2Ges8oYDA34YipRycpVtD8YIFixWILlBpyHAfqWgMowyFCJWkkRk0n/aBhCMXRcsMzfUeGzzvHigIhTTi61Hjrus64q4w2Mbf27f2PVz6OBdaKxHHcvsCZmmpuSlYOhBGCej2wCNRpQ/4t3/JNXKPKWeOCjZyq42Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=QOsSVG92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9AUw3fC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="QOsSVG92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9AUw3fC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D4417A00FF;
	Wed, 24 Jun 2026 10:21:37 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782310896;
	 x=1782397296; bh=nAf000Bim6H4HBDbYn1uuqI3XS3mcnv2A6Rt+LWm69I=; b=
	QOsSVG92Vg2YWI5BBYEzhUUnAUk2sJyc95FIytLdZ2HXu2T3hi+f46QnH60XS9jL
	kLOrpf6+osfkjplmMeETLARSlH5V2p5fKx1Nv8dL9tzKoQHCPtpAgDDDDN69LIm9
	J6ZGCNfHlXYvpvOHNq0z3CLB0k3LPnLPDRQe1s0i5aHX/YmCve1a/Vpemta/q8kg
	oriZCOohAccT0nfkN4s/kQ3rXlSkFC5RKwksaT2Le+HnyyQOPHs0j11XhqKFDoUg
	KVfzVeW2XAeSKT8YQC1IPhVPg+tciECUydyGjDjA3KDZeQbMs3AI45jq24RcRXLK
	QeRgX6vkmDzs4kjxNh3jvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782310896; x=
	1782397296; bh=nAf000Bim6H4HBDbYn1uuqI3XS3mcnv2A6Rt+LWm69I=; b=k
	9AUw3fCRJu74FDptgihNYkTNgV56+0jIam9dFLe8I9x9RvNIbHBlsG3IdquA7PC+
	GoeGWFqA6RDFiSXq3NPhKuUNjS2zm/eJm0gs2sDk9mlwV4itFr0JeLUPhBkk/USW
	QFN1XVWczeX5j5LiOJwJCGdthO06CWgsnfH+a0YwcgBgRa6+59FHVuGHyrfJl8TM
	osYdfG0rRt+3kXMLagb6dk4hRa4AE2slxnZAMBqMN4mf4oQQPTLbUnj3v/Xmq8yA
	wWWe1lGk8QdtDhfsupg2D8rCVVCvlr8rFzrD8VOK/bACeNwZVkXvmEv190M+OkF4
	wKfDETgDKw5ibGt3l98LA==
X-ME-Sender: <xms:8Oc7apgpVudvL8y0_SC9HgaHfbd8ekgYkGIqiOMrIiglCRKKHsc7hA>
    <xme:8Oc7ao0ZvezCgV7brWfhCp46ZAugMvOG4ZscvTa4Ha0k7JFgvaELDFDgJb5vy49km
    5thU98BNjh98AG9EJGgLMnPkSz3P_q24pLLqCyZBSoQVEHN-SSCHpw>
X-ME-Proxy-Cause: dmFkZTEA3g77jRwiY78nyJ144qnDWnzDgQdazXTyOURd7a1Oh+yGFZVmqqFULu1dcQmgkb
    ATZ1GWTqweXgrFxkGHcZ137xT6O6MZZoNpPDbzglDY2lCvmcedmeeXOScHoXXPjm6057bp
    2ZW8jODjWY0nqplrp7pMChB2ao3TeSUNBOPA4Yw7JRqI1rGmF4cl17zyrABT/Eh439U3gy
    FDHf5GVYNHvW2vORIsZmFs+VGcq4E5T/qVEOft3AE1/NpzjIDvVRqVU9hkwSKzB70WpaKe
    wW/YFTXgFPy+sCXofCEgKja6Rbc+6f9wNqkQpV8hVKh5HW7CRN0IISXeKKTEZH0PeVV2T9
    ytkg8JLzHhgxoMAC6HYEYxYOAoDZZ860znxcQQVEEhf+pylWhn9OeR/b+711Wq54KivH/D
    VjXLgdrnnSrMK/b6MAGrcsn4o839kB4LKbV5NHWCD1LY8XRT1SQeccyu7V5MI8UhrOqtzk
    wcAeH7h0fSdShHh0qLOCY/U8XGjo5a/etXEAxp51Yk1pKC16r/BHLhTyn2tKXlRlRiG2yQ
    KbM8Z3++74lCnW24N64exbEw28epm6YP3JsSRycSwcepdYUKQ4Bob54HvjjY32tqaBnFQ5
    eTysLf55pY9e5f+eWZ3DoRbNEWH08B6NunLZg4UbHV/GGrJaiYLgDGYMXn7g
X-ME-Proxy: <xmx:8Oc7anL4_JdPq2Fov6nCHRLKqMI0C3gV6Eblz0pedcC64sjYo8R5DQ>
    <xmx:8Oc7ammCmjGoD_gsQz6yo1CAZyalB1kcPnibUeUufDgxubwo-aLBeQ>
    <xmx:8Oc7ajPwqr4M4KD8iFr71EWg1qmYfXX5HCi7ImaLS7HjzqXxQlnNag>
    <xmx:8Oc7ak3-xoZc5PWI8TB5I4T6icC6dJdWKIkdcmqGCwRSm09-cAOqzA>
    <xmx:8Oc7autjEwOEWtNBTIqByqASou6vfLLkrDy5ahdm8xY6brtwf-q4tXgu>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 519722CE409A; Wed, 24 Jun 2026 10:21:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArMcrDYeUHoR
Date: Wed, 24 Jun 2026 10:21:16 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4662b2ae-c30a-4e0e-ad6a-db7935a0a75f@app.fastmail.com>
In-Reply-To: <6c516e9a-1dad-4c02-aedb-52168806bd21@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
 <6c516e9a-1dad-4c02-aedb-52168806bd21@roeck-us.net>
Subject: Re: [PATCH] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and
 SE60
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2026, at 10:21 PM, Guenter Roeck wrote:
> On 6/22/26 07:45, Mark Pearson wrote:
>> Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
> ...
>> +static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
>> +{
>> +	if (timeout < MIN_TIMEOUT || timeout > MAX_TIMEOUT)
>> +		return -EINVAL;
>> +
> Unnecessary range check. Unnecessary call, actually.
> See watchdog_dev.c:watchdog_set_timeout().
>
Agreed - will remove.
Thanks for the review

Mark

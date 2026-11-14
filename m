Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621513;
	b=ASuewtGo09tQVwIKXgvZdb4SBkb+5ayUhgPMZbvdQbhlTbBMRwBQGaF71DeKJn7l2TcQ
	 gZNKii7vyVuNVFlgdnadeRFpkWP3KW6ldaHS4HA7lHOd3DAY/6NwiJVr8TZwTTm9/+2Md
	 hSWnKd9cxk1kgo3AE4+8PPIKmBljFEl0K8f5uvvZb2gCcDqgd0sVng23h9HLNKS4Y4aZZ
	 6wiIfyo6nSRDDnHAsLvH3De8hbVDmLJSjrhDnyS3Rq0GLilIxqS9eYLk3wSPBexKdwISl
	 r7/YoyEJR2+iq+KycTA0QfpVAKCF1CL7lbvljjxDtayXxBVXARpfBMgm49nz9A10yfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=aL0LHF9pCJJuk3YgqGM4iDuDCVWIQy3ZFbQQg1gZzzg=;
	b=b4DDwMKkzr/dyuLWpNmUfRSoDPQP7CKOe+hnUrYQD2pCWLRrDGsWn5PpHb7y5A87Prex
	 H/DQ3vXxB9z52JG1ZsNEH6YmT9bJs6d/+O2Us2eDuDa7FEmqOjO487xwYlloEiFL4rnVP
	 2+RyIMjIUDHs+PqgnjJhMjXeCY+gJKiLJrX8KOaFTZd+OGXW43Hv/zST6bTbU0ZnLeJPI
	 lpokrO9qSQBglW/yGqzQHlAlpa+m/wJLVZZBUAoTvlr9lR1+Et976+xwd11E95sHs3mEq
	 X7JOhexJCE8c0mlxaa7UAFiqHvvFcxQcGI75p2yenuHqg2RTgbHRUI0L3EFEjKtktBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=LXlUxH1R;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17559606A883
	for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 01:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17559606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=LXlUxH1R
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso2925762a12.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 17:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794621510; x=1795226310; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aL0LHF9pCJJuk3YgqGM4iDuDCVWIQy3ZFbQQg1gZzzg=;
        b=LXlUxH1Rh6K4qlinmuEfrvRHc4tIMvhLHEqplfZu7iFjGmWKlS5Idc1cHRtAUMJ9JI
         I1SCjG5P19LQfH9XDGaGVy1kHXJ4cxMXZTvScOTgDF9Fs8GeorYt7vXmXa9YRYBrOWJg
         XQAZodWeb+Q+5Wikz7azb+9c6D684Jcb7TW80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621510; x=1795226310;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aL0LHF9pCJJuk3YgqGM4iDuDCVWIQy3ZFbQQg1gZzzg=;
        b=Cqkqvb8VOk4IivExgf0iQ87ftAFUAnxUbXzEAAVVmxYplv5MpvR/AP+YDdmmQC65cI
         8N4CUQLa11lW95Z+QuN/U4EXI4nk4KpqnF2H+LFaoDwnD5j4w5Y2+E1LNpKmPFmzKdLz
         8WAE6Ij4P1jdqjM6OVJqKDn+5wC699bT0VgBOKdKLCpQ3T/NVQfpk0BBKRAAu5z3hQ0a
         ezmuUWWiwOwmdhrZEJOaxJNsywGJ8FvkCYtAw2vsclOgwHc4dZfOHUAk8a0+73j+SKXh
         pgfNFTD89H7hUC1YAJ2E5aM8NdngYGJYQLdk9GwIRKJNu7vz5rHdgrwK2AjSoX85wKct
         cgcA==
X-Gm-Message-State: APuU4Z/5iLLYVr/6zPBT64zGazggACGHVnRveghaAD12CLYCzv2FP+KN
	8Cu4Ew2NVJIlxAdD45aFKvqv6NxCe8oR+AAmuQiXpHQKVz9ENc8dTRVLwhXD+NCy48H5U3Rvx7f
	UYYalNkPaVA==
X-Gm-Gg: AYBFou3UsoOXQz+aALg2nXdI8zTaUjBdVs3QRdR+SVW6FqtN9klrcHm9wmKDuuYnbCX
	YFPGnNu41l/B5mm4eREz7Y+V1aW9SL+hsSHeH7DKNyUqNaKobCR4aj1ByhZ89ohuKM5MhhB85w9
	l3LHIjoTb3zjKaYEHB6141tnKxDUNBvUCu4V9UHLdwC9Vx2cD6iRrC6XpPQ/1yLKAcXMqSnSOPz
	ynuTSx7tVdXXQL+Z++CFlQAt5B7Fe9Z8w+UKAxCJnI/VDKegA3YBIPjR1hVdBBFB0DnW1STzwoP
	hus9alTHAsnNMivEHDGygeUR9An6pwmMBWa2Kl4ViM6CnO6P0pyZ5C13Wa2hcFMvkK0DTCxVHp3
	31L9gzhUZgsKlC6KuX8cdoiVABaEHxyut7usjtgGioo3HHjJQsN2oLqO/2ncdRQlGCsaJEXfiGT
	yXuzPqKnkT0v9FnISkcVMc+QkvqyqGqzW4C0RPsrUrqV8URNzy+TSAr9TlfJDPuC5hyzrgHG7m1
	RD0KPohjg5eR4m6r3VFGzsscv6JkxMYkFcKuJjIlBu0+QGS8KZoIpovejOYJlCX66/SXFDO1rex
	5qDYhnCGGFei++iQevhJwO8vAp+XTrm0LS4t4JhkBNm7hyTNKSw0aLDAO+Te0aezyphw5oOti1O
	ZU54=
X-Received: by 2002:aa7:d813:0:b0:6b7:9290:dc64 with SMTP id 4fb4d7f45d1cf-6b7c0c52797mr2728989a12.33.1794621509953;
        Fri, 13 Nov 2026 17:58:29 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c235e605sm1737468a12.11.2026.11.13.17.58.29
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:58:29 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4322d310e7so382646266b.0
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 17:58:29 -0800 (PST)
X-Received: by 2002:a17:907:7faa:b0:c2e:350b:7220 with SMTP id
 a640c23a62f3a-c50962ee306mr382948166b.9.1794621508960; Fri, 13 Nov 2026
 17:58:28 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113200720.2752960-1-linux@roeck-us.net>
In-Reply-To: <20261113200720.2752960-1-linux@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Nov 2026 17:58:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7hJNG_tTrrs8RC2YOko89VdC3enAM02Q=X387uOqEyQ@mail.gmail.com>
X-Gm-Features: AclHuK_DNyPj3C43DT5p2t3qunEiw1JrghHTzZ2xWOYLj4cHJlEoticaV3NVHr4
Message-ID: <CAHk-=wi7hJNG_tTrrs8RC2YOko89VdC3enAM02Q=X387uOqEyQ@mail.gmail.com>
Subject: Re: [GIT PULL] watchdog fixes for v7.4-rc3
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 12:07, Guenter Roeck <linux@roeck-us.net> wrote:
>
> * gunyah_wdt: Re-enable the watchdog on resume
[ deleted]

This is simply the shortlog just repeated. It's not even edited apart
from some trivial sed-script. That's not a summary, and it's not
informative.

Can people *please* just write summaries? See

   https://lore.kernel.org/all/CAHk-=wjsj5evNKrhY-LRARUGYXnNAPqK09GHAEJ9sNLoKn4dyw@mail.gmail.com/
    https://lore.kernel.org/all/CAHk-=wjk2f+Vu656fEa7FOyHHaFe+-M-GEwUQPXykaYoor6A7g@mail.gmail.com/

and hundreds of other email requests like that.

I've pulled this, but these merge messages are *useless*.

              Linus

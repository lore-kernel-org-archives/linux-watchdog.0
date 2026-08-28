Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C84286AC
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934056; cv=pass; b=MyIt8sLR/K/kE0Tj6TwryZ87LxTZ/jzGSE7N7M1v33vM0ZuQIufCzO+f7Sb9h7Uve9/HJ1UNKMxzr7uYpvpjpeQZpck35KhLT5ltUdshGV+3qPQbxc5owcB0AQT+cvcbnANLdBNplRIlIuw2gHW5rUNKBRI9i7L6NXvqeUXhbEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934056; c=relaxed/simple;
	bh=8YPYDYkrQlrR+CyxlVZSwrQX6xFTern0V+PoudwjWj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kus7Sh5fl3657xZ5zPYVGxgzWtaM/S1nJQpBHLYoGH7HFPSH1b7LAU4pTqoXHPjb0UtJfUXaMhSRMZ9ADrKfEBivOIbD+EZfodeZ8DFs+bm5xHYvecIey2LnXwHnIqQkBI0LXNxwpG2Z0UdcLW/Ykey3VPgQKqzgbaiQzuX3nFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=ROkzyXgl; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="ROkzyXgl"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-857f1be346dso6787537b3.3
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 09:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787934053; cv=none;
        d=google.com; s=arc-20260327;
        b=nJ+2822xnSnqBiN6qu8Ba4YWV6ra3M2WHSRO2b+JYV6ypHQW0lu5DH52alxvfKffXV
         sxv7Ngb4arJQnDJvkKVV00V0TURzOWBHHz4K76/dmliw+WXuS8p9fGO8yh53BcMfDpeM
         hPc7L21FXFeM0yhCh9wVacoLqXbeol6O2771X1/ebYIsSgFz9iSyKGRQguMSogBP0wn2
         tzOKZksMXF0iRuC0lmp4+mcjqXRXCJf3zXNvhV3i6GeuZiNs5Em/e2JAjqgL7fWqC/5T
         uCVwVb7evu2yIIPCg2FS3v7N2pVLjsd6oxBLzOicLsKdxk6oLb3xTtmxvwbCegSY3Ka7
         ghRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8YPYDYkrQlrR+CyxlVZSwrQX6xFTern0V+PoudwjWj8=;
        fh=QCrqBI13uVHzXnlJ21V+bBCKQbUlQS4PF8v7yK9Q2aQ=;
        b=AO2PcXdwLzIf6Ceimgzua4QE28fFTSs3Iro/CdOj17k/c0eVMLK2+4wxJ/xLBmFQhO
         9AxFUxvMtzy8fY9m97yP6GmmyUx9CnYUUQb4Gl+fPnewCsBi/uLHSsY6rYUYsxv237Dw
         hk5gUJS0Uj07t75GuvATI6+WF/v4gOAU8qntmPAXpD2jS1y9P9vwc07EzivVjGeulsuP
         BtFHXOIEoSinmjKuiDFrEfHsejT2/bNPx/HNTyYQtgyaRdcyPSYZlCIt5w+2XFdPO8N0
         RVxy1ariqAMxpNVHIKwHqOLk2bxr5iG60C2ydnhnUd+PlPQUx+/F0jflSghD4uexOX+j
         SPvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1787934053; x=1788538853; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YPYDYkrQlrR+CyxlVZSwrQX6xFTern0V+PoudwjWj8=;
        b=ROkzyXgl/Q8sQR13oSIg9gJjoWkEkjMe/8keLGCT3g+mN3dTY1soanV123s8nG+q3T
         xidYtbgOq1jPg8uMmhIgntOBhlGg7zOSb5mqtLlEwwPedfvueZxhABimwKZ10ex+bGhA
         VM/XhlOniYAVBJUSYkQhWzbHIHMNO4HADJHiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787934053; x=1788538853;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8YPYDYkrQlrR+CyxlVZSwrQX6xFTern0V+PoudwjWj8=;
        b=h+/RbHS18VoKgQ21Rfa+Ohvg6x4Zcacq+52WfMBGOBQRJ/GBEVL2Fo4MPIrArbNXXN
         5R5k0u4qz3912TmCMNolCoZhMALkdjHLNPDVIX2OFP9ErnrVQyBWFvwngp5Lr0keNbdM
         pqc+F0cSUSoZYHlLZSrzN7+iuYlU959G82tKYXC0Yu5FhW9zCI85NuJeteRFINi0ODJX
         07ImS/de2fu/IzLtb2E4MxAYbwZ020wPbzpZBA7CVyVQCcN497SYMvl0w1QGVsGEc4eR
         62XTCUPNYfFEZRF2V40OoHcyVjGdCJ0SbO9EUJKxYluLPE69l+TGKWoq7UJWyIVDU52z
         zDJw==
X-Forwarded-Encrypted: i=1; AKwUvBxP0EFXuphp4E/46uufY1lIcpBw85Z+5aEXGom6L0KpRLCGQOh/kKMn6jZcQhDdzqK8kXMJUgubU2RE9/8esQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k7JxWgwlIFe9LtaW2Fwc34elSQbYbRWqUi5NkRIr0c0BQTm7Y7
	122qLDpurIdNUA6/vdHeAdznxK8SPxlmHVLiQH41akQqYOQYPNFqj9fRBWqGgQRPtVuFPtYJm4Q
	rAkOr0lGYcLdbJrlw5Vv4VYpbyRM3sfHguQYQ/Jlf7BAJeTGajkAN
X-Gm-Gg: AYBFou1DI4kM4GLWcy+Ig3IDpNCekiLx5apN9kiSSGbBOxnLBWZoXSVowojir5CK0Ei
	dvNZfiEzSv9KVVxgqMz5fB6KOntWuICFXsKEfMQ5kIrA+WaDPkbyneHRjK5zoL+5EJ3Ij8k6Flv
	oJUlR3mvjD162V6Ps6fjm3ROTbG6DoEdE8Dzrryoyg0ICvflVKXoUBWiNiwuMtFoAanaBOljjeB
	vlsdr334vvm6J9p7+XQXwhhmDLY44g6Djb1wcvvKnJVXoVEYI0KiuxzfTFBeAzfwpbvmeQmzSkL
	+lhKuXtK7wv+QDDbjfEHlGovW5dkf9UscnhS2JNFuBtdF8hcBDG+VPqwyrFLZHKjOJCtBsxnGlQ
	CAC8=
X-Received: by 2002:a05:690c:39d:b0:855:f387:98c0 with SMTP id
 00721157ae682-85d6c7ecff1mr29590227b3.29.1787934052949; Fri, 28 Aug 2026
 09:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828161348.13212-1-tzungbi@kernel.org>
In-Reply-To: <20260828161348.13212-1-tzungbi@kernel.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sat, 29 Aug 2026 01:20:40 +0900
X-Gm-Features: AcwNN1WVkx5mI84Kje1AxK5jgHkZdrKfEJurGd6o3lFFPv184PlCKpPhfQ4j4_A
Message-ID: <CAFr9PX=PugO9RKGsD_E8o_fqfZAXxKFU27t2jBm0qT-Er_Kaew@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] watchdog: msc313e: Fix issues Sashiko reported
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Romain Perier <romain.perier@gmail.com>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tzung-Bi,

On Sat, 29 Aug 2026 at 01:14, Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> The series mainly fixes issues reported by Sashiko in [1][2][3].

Thanks for looking at these. I will check the patches on hardware over
the weekend.

Cheers,

Daniel

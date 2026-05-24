Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FD2C21FF
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779642354; cv=pass; b=XWGWLJdHLh+kpi1lNqjaD4mzQ0WUcExzPTDzeDxzxrUTorRIN1N78kPQMvJ6YDKMr0K/F+SbeatYtBFrYHWBD1TD2373jpujVPOlIDGpY40BZbxtMpyeoAXVWdEeuIRhAScR8q5hlLow3+rd75HcfddczKVrG4beKXYimy2b4XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779642354; c=relaxed/simple;
	bh=4glvt49cLi6+cST7/0LjSJ/BDnh9nIOZ63q04EU7qFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrao4/1KwGhtqGMRb0Nss3E0Tb25MF13na9KfaYE9NE6BZaoJ0J4xS3clyC7Xts5TrlB5lNANUcDhiGsVQOdf3NDwPz2xS7Xk6Qu8IlJsAI1TfZSVR6EK532AGQ7Pg4zyCnXsjy1lFDGJhHQg0t1lAEJU7x9LkuRmTP6XUIwAXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHR2lFAn; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHR2lFAn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso3675891a12.3
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 10:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779642352; cv=none;
        d=google.com; s=arc-20240605;
        b=SSNFo59P7Ff3c1Lph3mZ3ZOPSf9CYlQuPE0p9eRUoFRCLbqLKnB7p9bvLy00o34doq
         4nhYg8XoscgTnnM4TgIBz1Px62Zn9BeISKna/n4pMOr4AQuQ7SDCnN0XVNjQ29q41/Xn
         jK/2ne1Soo9YUyRqvmpEUPAVH3TZGjM/yTYK9nQpEym8gW0qYSxrmPNfD6yAAAyXTMmY
         YZFQtb9GLWjgHJjqBlZYwD+hNAHaCkhl4De5pMam2LFd+9mgY8XjucInS0R/AJw7OOKX
         VgzG8drd6+gl6EomDIobM42/dLFkAwetaLUDVN6HXWy4Vm9VCCAxKbpA7CtkS6TmZPwp
         Jb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4glvt49cLi6+cST7/0LjSJ/BDnh9nIOZ63q04EU7qFA=;
        fh=/wVGdz/c5Rt5Ic43VFfHoSgDmK74dUBs6S27c18Zz/A=;
        b=GxRMOUZOfaouqVss9OggwNc3Rf9hXohJ+Mp0hmkHBq9lqgZj83LVRBUkYDa+5zEjrR
         4foPPueU3OQ6UjQIFlDxo8wNjmqQJ+rEjzoWEOwPUtxsfYMP6Yq8tSiel2DfdIR1npOL
         Ns1a8rGwRBIPJAD9TipCZoPIhSgpjfYD8bHaDlp31lUTmyTDJzVPWHQfTf+iyvT7Azk6
         phiiJugvgvwMiJfiI87LOCppl4wbbk9HqXm4csB9X8kuVAA1jTDmcKV4JGbOlKpjkv6z
         nwZZzJi9sC3YCMXvMrGlrbzcSWRWfw3J7JeyP3tZ1umd0vJp0dod5fmKSXsmGOHMdR2h
         uZKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779642352; x=1780247152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4glvt49cLi6+cST7/0LjSJ/BDnh9nIOZ63q04EU7qFA=;
        b=jHR2lFAnfN4Cu7VmUEDMFaqs4VVl30dnP+OpFzWTmcU8DWX84zfMpsPOEQ8ym4Pvqk
         GeEmMpMIIjhX7A5XCPeHAOxnpEaAW9DDSrWkJ0C+Y2VLXVF/w53q4jDNSlj0KMy6YjQx
         FbLStCvh0gZ4+c18RP++PSZ2udE7AabNQRymvrZQ1nJEk3tYrqXsw8HiVbp+9OAtVO9E
         Kw5OR8rl2BTdYkUlP4vHa9iWmsKYbIJt777/lnj2keENKxAxupNr4n4hiXMMsh/x3MAK
         klxgi022Z6i9Yj0k9asBJTEb4TplhELNicukxqzenbL9kJO9wp2/x7ZhhlDe34MSuMx2
         8DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779642352; x=1780247152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4glvt49cLi6+cST7/0LjSJ/BDnh9nIOZ63q04EU7qFA=;
        b=LexyrPOXhMd5Qfq3zGXWyXdzBa7mzyUo9fs5elNDQpR7K/2oUap+k8eC7tyVrLddoj
         s22vp3G9qJ+9ZMwkF+UFfpQiG7jyXB5GT4Xe7caJpfHOA+IqbC93sDOKbS0972k/7JwR
         7yUiVJXUMIIe8ZtgZoAUlz2exxMFmk0wmb1vbb4hRQ0N4x4lYsVaNTlNGjjIzP4P7vB4
         xfkIxgm9WKPLrZA4xL4mzjV1Q9KyFQ9+2Ie3XanTdwe3yNzjuGhwoP5UgdO08Cqu+KmP
         9D/GqHtz1zoXi7HYWHnyZcTa7FamfLeLRKzu+ZQs7KhxQA/WwInWrbJzq68ps4mdzIgV
         xtYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tJeBd8PzG8pA/M4vzV8wPJGslVLiNWG02iIAlCsb25gAVBHFoCtpD9B+BbT2O4U7z3h7UPbkUtWnlmOhRmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dfQ2GIGR8JH9bmItTpvrIPqhqH9Y/MxKW86SuA0g3XM/6nBe
	7hjiymhRa4a9HH2RdCX8HBmwX2WA1kTyl0tlaPZx/8TuB0WJiASCdp8RMVbu4NnPTH2GupXr5Oo
	ik41t1uaaogSXEv0pqKtbNk5dgRsqSBI=
X-Gm-Gg: Acq92OEM4Q8HgEmNCoB8M4PJ6P8e/nh7daeObCNkD0hBSn+YozjyzwNCxpvosgmYVME
	Gs4hyLCRZ5YfaWTL3iyKo7X77MrxyH1X0WOTm9Cvhnt0tMu/5oc3by7qAcF9EEPALQoTY1X8poA
	GTUfUjuSu+yr5p27Op2kOP4x4KG4i+eFuA5V+PTr7VV+38xUtcP2KL6e9Nt4h2WOZzi0ph14EoY
	521z973e3YzaMmGIfGQEaKWtnZitWnzFiJUc+35+XL4js6N6byslp5ee2hdtABRahGPWfLO6CPw
	b1Nl6qzRHlexSe/FtlEmxwK4em93Ux6HJqB36zT6r9dk3UBSdG2TnjweczKvqtyH
X-Received: by 2002:a05:6a20:12c4:b0:398:bda8:d8cd with SMTP id
 adf61e73a8af0-3b328ca9e5fmr11587685637.7.1779642352275; Sun, 24 May 2026
 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-sprd_wdt-v1-1-2e71f9a76ecb@gmail.com>
 <5ec9bd47-4c58-485a-bc20-1a74cbdef40b@linux.alibaba.com> <CAN4SLj09_mAPxR+k-qnOc6LWwh3je4-DJ9-BrfGR_FoEefjfVg@mail.gmail.com>
 <c619ebd2-c9ad-49d7-a9be-7b3290605b88@roeck-us.net>
In-Reply-To: <c619ebd2-c9ad-49d7-a9be-7b3290605b88@roeck-us.net>
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 25 May 2026 01:05:40 +0800
X-Gm-Features: AVHnY4JdX_h5GQFf1_PInT0KsyV_y5STAWwKGzlkced56-Yvt2aktuilrFeAt8Y
Message-ID: <CAN4SLj0OcBbongppvyG3--UhQX2KV6-thLaYGCgcg+jgb3s_xg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sprd_wdt: Remove redundant sprd_wdt_disable()
 on register failure
To: Guenter Roeck <linux@roeck-us.net>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 10:00=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 5/23/26 23:04, Felix Gu wrote:
> > Hi Guenter,
> > Gentle ping.
> > Is it good to merge?
> >
> > Best Felix
>
> I checked. The patch is queued in my watchdog-next, and I just confirmed
> that it is in linux-next (next-20260522). What else are you looking for ?
>
Hi Guenter,
Thanks.
I didn't notice it was already in the linux-next.

Best regards,
Felix

> Guenter
>

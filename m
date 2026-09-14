Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5641F348
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377674; cv=none; b=rw0Ascil6dMT0XjPXBISyd/7BJzR93voPPPneRFfYXSrjaSntWTf2MZy2RfHYHseIbM0OPKAAQBObvVVSW3IfGL6nmOGMQ0aoUygGkoDszPiyIiO6NQ4/ygPdv5a9R9yiKmSsjSxzjvXkiCd77I7D5l9PVmicFtgs4p8dpo9Cm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377674; c=relaxed/simple;
	bh=NFwOUB8LNevhQFYQ3HgiB/dniCw5BxrZrjmLeU2SyVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv8HwRDc/sJWuLriWn75r4GyFZhKxYN35q3qJS3JPmUx2IvKNX/+J6kEioTfqfg80Mik8mz7qRM6TVa8+VyQcO5fVNxKH1t93JzyprGbcZnxtOiI8EaB475vzXIRQXkQhDTZWQK/u9brBR+C59d6AhTyX7uWHWLAIBH80BE5x9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3hfAWfs; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3hfAWfs"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed9865so15118795ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789377670; x=1789982470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zT0oCOu16lcatVlgDSURGpdGxFQF3bYKh7NMExjIeBM=;
        b=h3hfAWfsRcRonshoqNKUC3Y5DakQH3+xmjKxt3kSHMrdfJtJyFqWhhMeCVdZqgKDRA
         O4H06CUFu+QPMoC+apK1KQs4H0Npaisyu5iLwETYLecMWszXMbtNFSoydBWJAEmvwyXi
         Nnc+THVnHQj4mZ1AiwPJkDo36MaqGc0BYGdvRzESkNUcPpVsl4xIi7MYdJL8QvQ6SS6j
         kDv64c7hKbuiMmMtqwCFJ8q3gV+1Pg2c7XnrOyN5buFBe/R0Ahv8AYHb21K1zgEzKOrI
         aoiD7uJgKE7wBmhZ+Y9l3N3skMRbiYT/l3GmI6WrSKoVYQenOrdkuflf0b82Tx4x8KaH
         cyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789377670; x=1789982470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zT0oCOu16lcatVlgDSURGpdGxFQF3bYKh7NMExjIeBM=;
        b=QSc66LLOAXAUO3u15cdRLszVcxIy0AAOAFjL0ZZRUvZkdTt/Yg5a4OyW6uFV4vQ4+Q
         YkY9Rhe88CvGP7J6mkYBUWh8rY9AB+FrozE1HXZf3s35V7Ald2fg8KMnY8GhlW9bTtCa
         GvX/fC0cafz2LY7xi3SXdBqy6DjBeZCfKGXmlmFKaAbnTHG+3RbNnf01I/nSvwUbxAo2
         LsnD71Zxmmyzsf92wNkbOua/ZVD7ikqQpcuzL1oVmgEgL46e+ZUF8csJPqniTI1xoQ4D
         eiho0zFfsDZqtx8JOHb7gOpVhzIR1vCKD0TYnKwz5NaNULFRya73Y3rP1n5TjK6JiGny
         T2SQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMYxHSlOIu87ezCBz4Eva/2oDwI5Z/WBzfiDSSXBomDFXVLCY3WcYgFgA7wjaJwYJyvnJY/dijQTGp54xjdg==@vger.kernel.org
X-Gm-Message-State: AFuF++lPhO9/0bhOt8iHnZu5DcRLIYSyuBRsxPpVamfZkGFdKmn0Q2Xb
	oRD9gPHHcAWi7g3SCr+S2kNd6syFZv7NcGkuXuWkM381UvxnfWeNJIg=
X-Gm-Gg: AYBFou3L5jzQSWs+eCnnV/9WC5DhJFsGSNqsVfbZvjNc+TpcYomw55VPnZwGRZ5Ij38
	rB6z27NtB8EGXXohObVHqyfCmLZsZn6xXGN67j0yIVNI2vkoYOxOk7MWK34ixRrlWvTZc3Nj97E
	5nTfrUe+qITemp31QHbsalP6+dBZ12xwBiJB5IJWxPmVQ/6FEfSa1IuxqfW3SWKa/F0Lb7SOxoz
	zpZ+S1fcpJ5C/sfIiHd7DZs89B5KK//EDBzczibFql+eDfE5wLpdWZRWL9678sMAz8w6JUYRHrU
	wCxThf+cUrsk5o9tIRW9MMXGxfkPQ5T9h3LKELAuxn3sy4ZIsgaJoEqpoEg17JmX68GVQmX0kg9
	lox66D6S8UjFtYzoQgyMM3I04zxV900IYVMPiVZ1eNAmGOF4H3F8QID1IchppvHY4q32G6jh7w1
	LmbbPEdcqYn73oMn0d6rv3xcy2bus6RsLDYt9ewM4rrsbd9PTWMaZt8RU+TvZ3wArGKCMLAvPrq
	QLCZElGqtvD
X-Received: by 2002:a17:903:f87:b0:2d6:fee6:65ae with SMTP id d9443c01a7336-2dd6c5b16famr37068635ad.4.1789377670362;
        Mon, 14 Sep 2026 02:21:10 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b8asm45067855ad.5.2026.09.14.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:21:10 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: triet.hoang.dev@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	tzungbi@kernel.org,
	wim@linux-watchdog.org
Subject: Re: [PATCH v2 3/8] watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 16:21:06 +0700
Message-ID: <20260914092106.901496-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914085451.891675-4-triet.hoang.dev@gmail.com>
References: <20260914085451.891675-4-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 15:54:46 +0700 Triet Hoang wrote:

> @@ -284,7 +283,7 @@ static struct platform_driver keembay_wdt_driver = {
>  	.driver	= {
>  		.name		= "keembay_wdt",
>  		.of_match_table	= keembay_wdt_match,
> -		.pm		= &keembay_wdt_pm_ops,
> +		.pm		= pm_sleep_ptr(&keembay_wdt_pm_ops),
>  	},
>  };

This shoud be pm_sleep() instead of pm_sleep_ptr() here.
I forgot to change this line. If needed, I can send a v3 to update it.

Thanks, and sorry for the inconvenience.

Regards,
Triet

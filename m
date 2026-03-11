Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641E3DC4A0
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231402; cv=none; b=ZSynIn9y+eX8yegCHVduGlpYIDLzLkpzdIiQyXB84ixqpGf69sw8R7MIC3Z+KY9lfK/mQWJRxBQ+aIQHEYjH5JdL1DEkMmMjY787xYmHDoHAulOH9Dplq+uvomAckUaHaLD6ZOnB8vZbPh+YMcJd5GCr3zwNpCTjgKii/LlVpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231402; c=relaxed/simple;
	bh=vIIr03THJBYTb/DG4le386ANTxRBzJD/TkuNIFzBbbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1KlIy0p1GgJ+tCBIWThHrwxFNldG2OV/4LkDlq4PQ+Wti7nnUVVgJ+2SssF8v9Y8LjjKMibsM1pTYdyssU2BkwNIrx7fYOhuT4FJYSLTOeSiW/SF3eWXVFHcTNOl6eQqP9B0UG9ybfqHh6dJwGBPbDb1Zp2QarrVi0NXrFghMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSf4PrMr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSf4PrMr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82989744ee0so5659125b3a.2
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773231398; x=1773836198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8b3+dFQJmOFN0qdzKY9BzCR9rFLTY9mbUUY2CWBUCc=;
        b=YSf4PrMrUQEGHgSTYa+Dlj/T8fA4Dran15+CON0mWkPYZvh5OgsQChoIw+ypvIAtzS
         4st7YIy5/k8/TRdCwIOeg838gJIbIt/el1Z8AkNpFl9R7fLR6ud0idZMCu7k7UNR1Q5S
         BK3IpBnz+m20KovtuMI3MInvbi9EU2BOCJ0OvYYc8ChWGxNay2x6fH+TZGyr5oCsm3m2
         KTJ0J8x9YpfFREw2qpR1bfIIO0e2yVqiU5O/BKUM1OhD7dyn1ZTbokLHgPFf16kXJXHK
         v9/ZwtPpkzZFLRN0dKxLSmGxNJS9Ztp6fr+oT2Sw9ZYst40V/+wnZj7rQqzfuJSe9Lua
         hf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773231398; x=1773836198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8b3+dFQJmOFN0qdzKY9BzCR9rFLTY9mbUUY2CWBUCc=;
        b=GtrzZ/rjGFZ4UBrKfw49NR+VoFUILdYYvFsm/MH4Iqm8ZzmTHPmQKnnfid4HHik/qm
         L9iVp8XKJj4K/C83o3FKjz2sXiSiKcbgHO7PE1fDRL4b8jS6cDIHlOJVvicxCbTaqXQm
         NTOEzok6ZNk20FMT1MYa2MgjgR8um91OO93x0h6udV3uU8Md+kwl5k+50D1U8vG7vIak
         OIlxIPX2N04lbSJ72TGQn5SoGXL63/mg8Tr83AQ0Telq+ymRaPm1vpSVtGHKfUPsjF0Q
         3h6RkuWIjkWX4kjHGwzZL8XLBz5RYhb5HbrQP0qNjS3W3k6LYp5Zl742nsHdPHBbzoXM
         CLpw==
X-Forwarded-Encrypted: i=1; AJvYcCVrYN342DjcvIWbKVju4+KgQ340oB9yT6JevgOwUKYMVfPfyyMR4H53CryZ4FBS5zCyZ+r6fNNYTuWKZZGpQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYn9i5TBzH1rgE4tkv1sgKbJm4l+el0M2DTrooCbOH7BYj7MQ
	/S2gxmy7Ev7JfnzS/BM3aWA6ECw/iayWJjf6VOftx7DP5ZLI9zCCS2/y
X-Gm-Gg: ATEYQzzr4SYdJrJBs3AxlvETn8tviI2/akHwZhk/DXEn6PqE9D5vmmzQnBKj3I67nTG
	Gk/02u0oF1LrlnIG/DXV8ssLhyMDsR7Uy6Knfr4m98qP2bNWaOU9xoHQh3BbPO3IR+SqeTxR0K6
	26oT3xcr8HxSfWPQV+QsPAsEWVIkPCbYWLvSwBGmO7inFZ7pKPvtgFr1e1lg40gdwOQPtTgHCB5
	3WSQKbZkU51DMEB/OJT8KC6jKkvrdGf/L13ZaZgsp45syywoPB+vsopZziHABOB82X7v48ykcA/
	tHUR1dIRrzRuR16GmTcjvg4Eg1HmdhubnzDgWF+b2I6lzJFCCc22xkZB/S24ZTe8KFt+vWTU+pJ
	FT9IRoO/yoX5JzjoQdzsRrkKvSZpwbxBUYJOA5Rv5K2diF+8p52T72RoE6YfK6Yjjl4OFhZpe+t
	bPkb6Sy3NcXJfQRmr22oXAkWO5OD+TIv9mNDNP
X-Received: by 2002:a05:6a00:3e11:b0:829:883c:1d53 with SMTP id d2e1a72fcca58-829f7089e1amr2181760b3a.31.1773231397977;
        Wed, 11 Mar 2026 05:16:37 -0700 (PDT)
Received: from fedora ([2409:40e5:1170:3c82:c36b:4f46:fd0b:d91e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eecc6asm2286294b3a.42.2026.03.11.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:16:31 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH] docs: watchdog: explain watchdog API options
Date: Wed, 11 Mar 2026 17:46:01 +0530
Message-ID: <20260311121602.139967-1-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace FIXME comment with proper documentation for
WDIOS_DISABLECARD, WDIOS_ENABLECARD, and WDIOS_TEMPPANIC
options.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 Documentation/watchdog/watchdog-api.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 78e228c272cf..984f7362d5fb 100644
--- a/Documentation/watchdog/watchdog-api.rst
+++ b/Documentation/watchdog/watchdog-api.rst
@@ -268,4 +268,13 @@ The following options are available:
 	WDIOS_TEMPPANIC		Kernel panic on temperature trip
 	=================	================================
 
-[FIXME -- better explanations]
+The WDIOS_DISABLECARD option allows you to stop the watchdog timer via
+software. Note that this will only work if the "nowayout" module parameter
+(or CONFIG_WATCHDOG_NOWAYOUT) is not set.
+
+The WDIOS_ENABLECARD option turns on the watchdog timer.
+
+The WDIOS_TEMPPANIC option is used by some drivers (like the pcwd driver)
+to trigger a system halt (typically a kernel panic or power off) when the
+temperature trip point is reached. This ensures that the system is halted
+immediately in case of an overheat condition.
-- 
2.53.0


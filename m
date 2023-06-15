Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E5EB64D9
	for <linux-watchdog@archiver.kernel.org>; Thu, 15 Jun 2023 10:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjFOKln (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 15 Jun 2023 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjFOKln (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Jun 2023 06:41:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51D2121;
        Thu, 15 Jun 2023 03:41:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D59101FE03;
        Thu, 15 Jun 2023 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686825700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hlEUOtHeOS9q5GbyKPB9dzh38Rz32G4pK7veLoBHTtw=;
        b=QG6XC4k62X+fb5IG0yKYMDGb1vZX+fe9I+F6J7Bw3x3MxakfVwRI8BJXZsT1ZCV9MWN+QU
        lLUidvOQcXEo62GCmmOb+/VOeJ4Fwwlxk5pCVin7RakKVL9E0CERXYzpxhux4656cH+BjO
        d2VUwjavOJZU5wY/vBkZI5WG/Sb2a00=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91C1013A47;
        Thu, 15 Jun 2023 10:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U6S7IeTqimQleAAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 15 Jun 2023 10:41:40 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Thu, 15 Jun 2023 12:40:19 +0200
Message-ID: <20230615104137.20304-1-oneukum@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

I am looking for people who can test a driver for the PCWD watchdog
ported to the new API

